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
}
