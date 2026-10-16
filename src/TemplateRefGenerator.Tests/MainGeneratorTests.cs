// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System.Collections.Immutable;
using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TemplateRefGenerator;

namespace TemplateRefGenerator.Tests;

[TestClass]
public class MainGeneratorTests
{
    private static readonly MarkdownGenerator.GroupedTypes GroupedTypes = new(
        "Microsoft.Test",
        new Dictionary<string, ImmutableArray<string>>(StringComparer.OrdinalIgnoreCase)
        {
            ["2024-01-01"] = ["Microsoft.Test/widgets"],
            ["2025-01-01"] = ["Microsoft.Test/widgets"],
        }.ToImmutableDictionary(StringComparer.OrdinalIgnoreCase));

    private static readonly ImmutableDictionary<string, string> EmptyTocMapping = [];

    [TestMethod]
    public void All_api_versions_are_included_when_exclusions_are_not_configured()
    {
        var config = Utils.DeserializeJsonFile<ConfigLoader.ConfigFile>(
            "config.json",
            """
            {
              "TocTitleMapping": {},
              "ExcludedProviders": []
            }
            """);

        var result = MainGenerator.ApplyApiVersionExclusions(GroupedTypes, config);

        result.Should().BeSameAs(GroupedTypes);
    }

    [TestMethod]
    public void Configured_api_versions_are_excluded_for_the_matching_provider()
    {
        var exclusion = new ConfigLoader.ApiVersionExclusion("microsoft.test", ["2024-01-01"]);
        var config = new ConfigLoader.ConfigFile(EmptyTocMapping, [], [exclusion]);

        var result = MainGenerator.ApplyApiVersionExclusions(GroupedTypes, config);

        result.Should().NotBeNull();
        result!.ResourceTypeByApiVersion.Keys.Should().BeEquivalentTo(["2025-01-01"]);
    }

    [TestMethod]
    public void Missing_excluded_api_versions_are_ignored()
    {
        var exclusion = new ConfigLoader.ApiVersionExclusion("Microsoft.Test", ["2099-01-01"]);
        var config = new ConfigLoader.ConfigFile(EmptyTocMapping, [], [exclusion]);

        var result = MainGenerator.ApplyApiVersionExclusions(GroupedTypes, config);

        result.Should().NotBeNull();
        result!.ResourceTypeByApiVersion.Should().BeEquivalentTo(GroupedTypes.ResourceTypeByApiVersion);
    }

    [TestMethod]
    public void Provider_is_skipped_when_all_api_versions_are_excluded()
    {
        var exclusion = new ConfigLoader.ApiVersionExclusion(
            "Microsoft.Test",
            ["2024-01-01", "2025-01-01"]);
        var config = new ConfigLoader.ConfigFile(EmptyTocMapping, [], [exclusion]);

        var result = MainGenerator.ApplyApiVersionExclusions(GroupedTypes, config);

        result.Should().BeNull();
    }
}
