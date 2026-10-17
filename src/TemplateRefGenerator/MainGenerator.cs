// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System;
using System.IO;
using System.Linq;
using System.Diagnostics;
using System.IO.Abstractions;
using System.Collections.Generic;

namespace TemplateRefGenerator;

public class MainGenerator
{
    public record Options(string OutputFolder, string? ProviderNamespace);

    private readonly IFileSystem fileSystem;
    private readonly ResourceTypeProvider resourceTypeProvider;
    private readonly RemarksLoader remarksLoader;
    private readonly ConfigLoader configLoader;

    public MainGenerator(IFileSystem fileSystem, ResourceTypeProvider resourceTypeProvider, RemarksLoader remarksLoader, ConfigLoader configLoader)
    {
        this.fileSystem = fileSystem;
        this.resourceTypeProvider = resourceTypeProvider;
        this.remarksLoader = remarksLoader;
        this.configLoader = configLoader;
    }

    private void WriteFile(Options options, string path, string content)
    {
        var filePath = Path.Combine(options.OutputFolder, path);
        fileSystem.Directory.CreateDirectory(Path.GetDirectoryName(filePath)!);
        fileSystem.File.WriteAllText(filePath, content);
    }

    private IEnumerable<MarkdownGenerator.GroupedTypes> GetGroupedTypes(Options options, MarkdownGenerator mdGenerator, ConfigLoader.ConfigFile config)
    {
        foreach (var grouping in mdGenerator.GetGroupedTypes())
        {
            if (options.ProviderNamespace is { } &&
                !StringComparer.OrdinalIgnoreCase.Equals(grouping.ProviderNamespace, options.ProviderNamespace))
            {
                continue;
            }

            if (config.ExcludedProviders.Contains(grouping.ProviderNamespace, StringComparer.OrdinalIgnoreCase))
            {
                Trace.WriteLine($"Skipping {grouping.ProviderNamespace} - excluded in config");
                continue;
            }

            yield return grouping;
        }
    }

    public void Generate(Options options)
    {
        MarkdownGenerator mdGenerator = new(resourceTypeProvider);
        ChangelogGenerator changelogGenerator = new(resourceTypeProvider);

        // clear output folder
        if (fileSystem.Directory.Exists(options.OutputFolder))
        {
            fileSystem.Directory.Delete(options.OutputFolder, true);
        }
        fileSystem.Directory.CreateDirectory(options.OutputFolder);

        var grouping = GetGroupedTypes(options, mdGenerator, configLoader.GetConfiguration()).ToArray();
        foreach (var groupedTypes in grouping)
        {
            Trace.WriteLine($"Processing {groupedTypes.ProviderNamespace}");
            foreach (var (apiVersion, resourceTypes) in groupedTypes.ResourceTypeByApiVersion)
            {
                foreach (var typeName in resourceTypes)
                {
                    var resourceType = resourceTypeProvider.Get(typeName, apiVersion);

                    var unqualifiedResourceType = typeName.Substring(typeName.IndexOf('/') + 1);

                    var mdPath = $"{groupedTypes.ProviderNamespace}/{apiVersion}/{unqualifiedResourceType}.md".ToLowerInvariant();
                    var mdContent = MarkdownGenerator.GenerateMarkdown(groupedTypes, resourceType, configLoader, remarksLoader, isLatestVersionPage: false);
                    WriteFile(options, mdPath, mdContent);
                }
            }

            foreach (var (typeName, apiVersion) in groupedTypes.GetLatestApiVersionByType())
            {
                var resourceType = resourceTypeProvider.Get(typeName, apiVersion);

                var unqualifiedResourceType = typeName.Substring(typeName.IndexOf('/') + 1);

                var mdPath = $"{groupedTypes.ProviderNamespace}/{unqualifiedResourceType}.md".ToLowerInvariant();
                var mdContent = MarkdownGenerator.GenerateMarkdown(groupedTypes, resourceType, configLoader, remarksLoader, isLatestVersionPage: true);
                WriteFile(options, mdPath, mdContent);
            }

            var allVersionsPath = $"{groupedTypes.ProviderNamespace}/allversions.md".ToLowerInvariant();
            var allVersionsMd = AllVersionsGenerator.GenerateMarkdown(groupedTypes);
            WriteFile(options, allVersionsPath, allVersionsMd);

            var referenceTocPath = $"{groupedTypes.ProviderNamespace}/toc.yml".ToLowerInvariant();
            var referenceTocContent = TocGenerator.GenerateReferenceToc(groupedTypes);
            WriteFile(options, referenceTocPath, referenceTocContent);

            var changeLog = changelogGenerator.GetChanges(groupedTypes);
            foreach (var resourceTypeChange in changeLog.ResourceTypeChanges)
            {
                var typeName = resourceTypeChange.ResourceType;
                var unqualifiedResourceType = typeName.Substring(typeName.IndexOf('/') + 1);

                var mdPath = $"{groupedTypes.ProviderNamespace}/change-log/{unqualifiedResourceType}.md".ToLowerInvariant();
                var mdContent = ChangelogGenerator.GenerateChangeLog(resourceTypeChange);
                WriteFile(options, mdPath, mdContent);
            }

            var summaryChangelogPath = $"{groupedTypes.ProviderNamespace}/change-log/summary.md".ToLowerInvariant();
            var summaryChangelogMd = ChangelogGenerator.GenerateSummaryChangeLog(changeLog);
            WriteFile(options, summaryChangelogPath, summaryChangelogMd);

            var changeLogTocPath = $"{groupedTypes.ProviderNamespace}/change-log/toc.yml".ToLowerInvariant();
            var changeLogTocContent = TocGenerator.GenerateChangeLogToc(groupedTypes);
            WriteFile(options, changeLogTocPath, changeLogTocContent);
        }

        var rootTocPath = "toc.yml";
        var rootTocContent = TocGenerator.GenerateRootToc(configLoader, grouping.Select(x => x.ProviderNamespace).ToArray());
        WriteFile(options, rootTocPath, rootTocContent);
    }
}