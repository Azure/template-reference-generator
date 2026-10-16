// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.


using System;
using System.Diagnostics;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using Azure.Bicep.Types.Az;
using Azure.Bicep.Types.Concrete;
using Azure.Deployments.Testing.Utilities;
using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TemplateRefGenerator;

namespace TemplateRefGenerator.Tests;
[TestClass]
public class MarkdownGeneratorTests
{
    [NotNull]
    public TestContext? TestContext { get; set; }

    [TestMethod]
    [TestCategory(BaselineHelper.BaselineTestCategory)]
    [EmbeddedFilesTestData(@"^Files/markdown/.*/.*\.md$")]
    public void Markdown_generation_works(EmbeddedFile embeddedFile)
    {
        var baselineFolder = BaselineFolder.BuildOutputFolder(TestContext, embeddedFile);
        var markdownFile = baselineFolder.GetBaselineFile(embeddedFile.FileName);

        var streamPathParts = embeddedFile.StreamPath.Split('/').Skip(2).ToArray();
        var providerNamespace = streamPathParts[0];
        var apiVersion = streamPathParts[1];
        var unqualifiedResourceType = string.Join('/', streamPathParts[2..])[..^".md".Length];

        var typeProvider = new ResourceTypeProvider(new AzTypeLoader());
        var mdGenerator = new MarkdownGenerator(typeProvider);

        var resourceType = typeProvider.Get($"{providerNamespace}/{unqualifiedResourceType}", apiVersion);
        var groupedTypes = mdGenerator.GetGroupedTypes()
            .First(x => StringComparer.OrdinalIgnoreCase.Equals(x.ProviderNamespace, providerNamespace));

        var markdown = MarkdownGenerator.GenerateMarkdown(groupedTypes, resourceType, new(), new(), isLatestVersionPage: false);

        markdownFile.WriteToOutputFolder(markdown);
        markdownFile.ShouldHaveExpectedValue();
    }

    [TestMethod]
    public void Read_only_resources_must_be_explicitly_configured()
    {
        var typeProvider = new ResourceTypeProvider(new AzTypeLoader());
        var resourceType = typeProvider.GetResourceTypes()
            .Select(x => typeProvider.Get(x.resourceType, x.apiVersion))
            .First(x => Utils.HasWritableScope(x, ScopeType.None));

        MarkdownGenerator.IsReadOnlyResource(resourceType, isConfiguredReadOnly: true).Should().BeTrue();
        MarkdownGenerator.IsReadOnlyResource(resourceType, isConfiguredReadOnly: false).Should().BeFalse();
    }
}