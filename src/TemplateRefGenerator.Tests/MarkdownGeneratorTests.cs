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
    [DataRow(true, false)]
    [DataRow(true, true)]
    [DataRow(false, false)]
    [DataRow(false, true)]
    public void Resource_rendering_uses_writable_scope_metadata(bool isReadOnly, bool isLatestVersionPage)
    {
        var typeProvider = new ResourceTypeProvider(new AzTypeLoader());
        var resourceType = typeProvider.GetResourceTypes()
            .Select(x => typeProvider.Get(x.resourceType, x.apiVersion))
            .First(x => (x.WritableScopes == ScopeType.None) == isReadOnly &&
                !x.Name.StartsWith("Microsoft.HorizonDb/", StringComparison.OrdinalIgnoreCase));

        MarkdownGenerator.IsReadOnlyResource(resourceType).Should().Be(isReadOnly);

        var providerNamespace = Utils.GetProviderNamespace(resourceType.Name);
        var groupedTypes = new MarkdownGenerator(typeProvider).GetGroupedTypes()
            .First(x => StringComparer.OrdinalIgnoreCase.Equals(x.ProviderNamespace, providerNamespace));
        var markdown = MarkdownGenerator.GenerateMarkdown(groupedTypes, resourceType, new(), new(), isLatestVersionPage);

        foreach (var pivot in new[] { "bicep", "arm-template", "terraform" })
        {
            markdown.Should().Contain($"::: zone pivot=\"deployment-language-{pivot}\"");
        }

        markdown.Should().Contain("## Property Values", Exactly.Times(3));

        if (isReadOnly)
        {
            markdown.Should().Contain("reference for retrieving the resource.");
            markdown.Should().Contain("is read-only and cannot be deployed.", Exactly.Times(3));
            markdown.Should().NotContain("can be deployed with operations that target:");
            markdown.Should().NotContain("## Resource format");
            markdown.Should().NotContain("## Usage Examples");
            markdown.Should().NotContain("```bicep");
            markdown.Should().NotContain("```json");
            markdown.Should().NotContain("```terraform");
        }
        else
        {
            markdown.Should().Contain("syntax and properties to use in Azure Resource Manager templates for deploying the resource.");
            markdown.Should().NotContain("is read-only and cannot be deployed.");
            markdown.Should().Contain("can be deployed with operations that target:", Exactly.Times(3));
            markdown.Should().Contain("## Resource format", Exactly.Times(3));
            markdown.Should().Contain("```bicep");
            markdown.Should().Contain("```json");
            markdown.Should().Contain("```terraform");
        }
    }
}