// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.


using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.IO;
using System.Linq;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace TemplateRefGenerator;
public class RemarksLoader
{
    public enum DeploymentType
    {
        Bicep,
        Json,
        Terraform,
    }

    public record ApiVersionRequirement(
        string? Minimum,
        string? Maximum);

    public record ResourceRemark(
        ImmutableArray<string> ResourceTypes,
        ApiVersionRequirement? ApiVersion,
        string Description);

    public record PropertyRemark(
        string ResourceType,
        ApiVersionRequirement? ApiVersion,
        string ObjectName,
        string PropertyName,
        string Description);

    public record DeploymentRemark(
        string ResourceType,
        ApiVersionRequirement? ApiVersion,
        DeploymentType DeploymentType,
        string Description);

    public record CodeSample(
        string ResourceType,
        ApiVersionRequirement? ApiVersion,
        string Path,
        string Description);

    public record RemarksFile(
        ImmutableArray<ResourceRemark>? ResourceRemarks,
        ImmutableArray<PropertyRemark>? PropertyRemarks,
        ImmutableArray<DeploymentRemark>? DeploymentRemarks,
        ImmutableArray<CodeSample>? BicepSamples,
        ImmutableArray<CodeSample>? TerraformSamples)
    {
        public static RemarksFile Empty
            => new(null, null, null, null, null);

        public IEnumerable<ResourceRemark> GetResourceRemarks(MarkdownGenerator.ResourceMetadata resource)
            => (ResourceRemarks ?? [])
                .Where(r => r.ResourceTypes.Contains(resource.ResourceType, StringComparer.OrdinalIgnoreCase))
                .Where(r => FilterApiVersions(resource, r.ApiVersion));

        public IEnumerable<PropertyRemark> GetPropertyRemarks(MarkdownGenerator.ResourceMetadata resource)
            => (PropertyRemarks ?? [])
                .Where(r => StringComparer.OrdinalIgnoreCase.Equals(resource.ResourceType, r.ResourceType))
                .Where(r => FilterApiVersions(resource, r.ApiVersion));

        public IEnumerable<DeploymentRemark> GetDeploymentRemarks(MarkdownGenerator.ResourceMetadata resource, DeploymentType type)
            => (DeploymentRemarks ?? [])
                .Where(r => StringComparer.OrdinalIgnoreCase.Equals(resource.ResourceType, r.ResourceType))
                .Where(r => r.DeploymentType == type)
                .Where(r => FilterApiVersions(resource, r.ApiVersion));

        public IEnumerable<CodeSample> GetBicepSamples(MarkdownGenerator.ResourceMetadata resource)
            => (BicepSamples ?? [])
                .Where(r => StringComparer.OrdinalIgnoreCase.Equals(resource.ResourceType, r.ResourceType))
                .Where(r => FilterApiVersions(resource, r.ApiVersion));

        public IEnumerable<CodeSample> GetTerraformSamples(MarkdownGenerator.ResourceMetadata resource)
            => (TerraformSamples ?? [])
                .Where(r => StringComparer.OrdinalIgnoreCase.Equals(resource.ResourceType, r.ResourceType))
                .Where(r => FilterApiVersions(resource, r.ApiVersion));

        private static bool FilterApiVersions(MarkdownGenerator.ResourceMetadata resource, ApiVersionRequirement? apiVersionRequirement)
            => (apiVersionRequirement?.Minimum is null || ApiVersionComparer.Instance.Compare(apiVersionRequirement.Minimum, resource.ApiVersion) >= 0) &&
            (apiVersionRequirement?.Maximum is null || ApiVersionComparer.Instance.Compare(apiVersionRequirement.Maximum, resource.ApiVersion) <= 0);
    }

    public string GetCodeSample(string providerNamespace, CodeSample sample)
        => Utils.ReadManifestFile("settings/remarks", providerNamespace.ToLowerInvariant(), sample.Path).Trim('\r', '\n');

    public RemarksFile GetRemarks(string providerNamespace)
    {
        var pathComponents = new[] { "settings/remarks", providerNamespace.ToLowerInvariant(), "remarks.json" };
        if (Utils.TryReadManifestFile(pathComponents) is not {} contents)
        {
            return RemarksFile.Empty;
        }

        return Utils.DeserializeJsonFile<RemarksFile>(Utils.GetManifestFilePath(pathComponents), contents);
    }

    public ImmutableArray<string> GetProviderNamespacesWithRemarks()
        => [.. Utils.ListManifestFiles("settings/remarks")
            .Select(path => path.Split('/')[2])
            .Distinct(StringComparer.OrdinalIgnoreCase)];
}