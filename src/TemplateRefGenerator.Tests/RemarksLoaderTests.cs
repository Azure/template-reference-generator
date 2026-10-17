// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.


using FluentAssertions;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using TemplateRefGenerator;

namespace TemplateRefGenerator.Tests;
[TestClass]
public class RemarksLoaderTests
{
    [TestMethod]
    [DataRow("2026-10-01-preview", null, "2026-01-20-preview", false)]
    [DataRow("2026-10-01-preview", null, "2026-10-01-preview", true)]
    [DataRow("2026-10-01-preview", null, "2027-01-01", true)]
    [DataRow(null, "2026-10-01-preview", "2026-01-20-preview", true)]
    [DataRow(null, "2026-10-01-preview", "2026-10-01-preview", true)]
    [DataRow(null, "2026-10-01-preview", "2027-01-01", false)]
    public void Code_samples_are_filtered_by_api_version_range(
        string? minimum,
        string? maximum,
        string apiVersion,
        bool expected)
    {
        var sample = new RemarksLoader.CodeSample(
            "Microsoft.Test/widgets",
            new RemarksLoader.ApiVersionRequirement(minimum, maximum),
            "samples/widget.bicep",
            "Deploy a widget.");
        var remarks = new RemarksLoader.RemarksFile(null, null, null, [sample], null, null);
        var resource = new MarkdownGenerator.ResourceMetadata(
            "Microsoft.Test",
            "Microsoft.Test/widgets",
            "widgets",
            apiVersion,
            null!,
            false,
            false);

        var samples = remarks.GetBicepSamples(resource);

        if (expected)
        {
            samples.Should().ContainSingle().Which.Should().Be(sample);
        }
        else
        {
            samples.Should().BeEmpty();
        }
    }

    [TestMethod]
    [DataRow("2026-01-20-preview", false)]
    [DataRow("2026-05-01-preview", false)]
    [DataRow("2026-10-01-preview", true)]
    public void HorizonDB_samples_are_only_included_for_compatible_api_versions(string apiVersion, bool expected)
    {
        var remarks = new RemarksLoader().GetRemarks("Microsoft.HorizonDb");
        var resource = new MarkdownGenerator.ResourceMetadata(
            "Microsoft.HorizonDb",
            "Microsoft.HorizonDb/clusters",
            "clusters",
            apiVersion,
            null!,
            false,
            false);

        foreach (var samples in new[]
        {
            remarks.GetBicepSamples(resource),
            remarks.GetArmTemplateSamples(resource),
            remarks.GetTerraformSamples(resource),
        })
        {
            if (expected)
            {
                samples.Should().NotBeEmpty();
            }
            else
            {
                samples.Should().BeEmpty();
            }
        }
    }
}
