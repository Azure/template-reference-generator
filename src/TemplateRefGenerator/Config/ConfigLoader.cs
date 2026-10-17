// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System;
using System.Collections.Immutable;

namespace TemplateRefGenerator;

public class ConfigLoader
{
    private Lazy<ConfigFile> ConfigFileLazy = 
        new(() => Utils.DeserializeJsonFile<ConfigFile>("settings/config/config.json", Utils.ReadManifestFile("settings/config/config.json")));

    private Lazy<SamplesFile> SampleFileLazy = 
        new(() => Utils.DeserializeJsonFile<SamplesFile>("settings/samples/samples.json", Utils.ReadManifestFile("settings/samples/samples.json")));

    public record ConfigFile(
        ImmutableDictionary<string, string> TocTitleMapping,
        ImmutableArray<string> ExcludedProviders);

    public record SamplesFile(
        ImmutableArray<AvmLink> AvmLinks,
        ImmutableArray<QuickstartLink> QuickstartLinks);

    public enum AvmLinkType {
        Bicep,
        Terraform,
    }

    public record AvmLink(
        AvmLinkType Type,
        string Title,
        string Description,
        string ResourceType,
        string RepoUrl);

    public record QuickstartLink(
        string Title,
        string Description,
        string Path,
        ImmutableArray<string> ResourceTypes,
        bool HasBicep);

    public ConfigFile GetConfiguration()
        => ConfigFileLazy.Value;

    public SamplesFile GetSamples()
        => SampleFileLazy.Value;
}