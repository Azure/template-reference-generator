// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Azure.Deployments.Testing.Utilities;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Bicep.RpcClient;
using FluentAssertions;
using Bicep.RpcClient.Models;
using System.Diagnostics.CodeAnalysis;
using System.Text.Json.Serialization;
using System.Text.Json;
using System.Text.Encodings.Web;
using Microsoft.WindowsAzure.ResourceStack.Common.Extensions;

namespace TemplateRefGenerator.Tests;

[TestClass]
public class BicepCompilationTests
{
    [NotNull]
    public TestContext? TestContext { get; set; }

    [TestMethod]
    [TestCategory(BaselineHelper.BaselineTestCategory)]
    [EmbeddedFilesTestData(@"^Files/compilation/bicep-diagnostics.md$")]
    public async Task All_bicep_samples_are_valid(EmbeddedFile embeddedFile)
    {
        // This test verifies there are no errors, and that the warnings match those that are expected
        var baselineFolder = BaselineFolder.BuildOutputFolder(TestContext, embeddedFile);
        var resultsFile = baselineFolder.GetBaselineFile(embeddedFile.FileName);
        RemarksLoader remarksLoader = new();

        BicepClientFactory bicepClientFactory = new(new());
        using var bicep = await bicepClientFactory.DownloadAndInitialize(new()
        {
            BicepVersion = "0.41.2"
        }, CancellationToken.None);

        var markdownOutput = """
        # Bicep Sample Diagnostics

        """;

        var providers = remarksLoader.GetProviderNamespacesWithRemarks();
        var tempPath = Path.GetTempPath();
        Directory.CreateDirectory(tempPath);
        var tempFile = Path.Combine(tempPath, Guid.NewGuid() + ".bicep");
        foreach (var provider in providers.OrderBy(x => x, StringComparer.OrdinalIgnoreCase))
        {
            var bicepSamples = remarksLoader.GetRemarks(provider).BicepSamples ?? [];

            foreach (var sample in bicepSamples.OrderBy(x => x.Path, StringComparer.OrdinalIgnoreCase))
            {
                var bicepContents = remarksLoader.GetCodeSample(provider, sample);
                File.WriteAllText(tempFile, bicepContents);

                var result = await bicep.Compile(new(tempFile));

                result.Diagnostics.Count(x => string.Equals(x.Level, "Error", StringComparison.OrdinalIgnoreCase)).Should().Be(0, because: $"Bicep sample '{sample.Path}' should not have compilation errors");

                if (result.Diagnostics.Any())
                {
                    markdownOutput += $"""
                    ## {sample.Path}

                    """;
                    foreach (var diag in result.Diagnostics.OrderBy(x => x.Range.Start.Line).ThenBy(x => x.Range.Start.Char))
                    {
                        markdownOutput += $"""
                        * [[{diag.Code}] {diag.Level}: {diag.Message}](../../../../settings/remarks/{provider}/{sample.Path}#L{diag.Range.Start.Line + 1}-L{diag.Range.End.Line + 1})
                        
                        """;
                    }
                }
            }
        }

        resultsFile.WriteToOutputFolder(markdownOutput);
        resultsFile.ShouldHaveExpectedValue();
    }
}