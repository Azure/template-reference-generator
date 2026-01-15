// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.


using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Text;
using Azure.Bicep.Types.Concrete;
using static TemplateRefGenerator.ConfigLoader;
using static TemplateRefGenerator.RemarksLoader;

namespace TemplateRefGenerator;
public class MarkdownGenerator
{
    private record StaticTypeReference(TypeBase Type) : ITypeReference;

    private readonly ResourceTypeProvider typeProvider;

    public MarkdownGenerator(ResourceTypeProvider typeProvider)
    {
        this.typeProvider = typeProvider;
    }

    public record GroupedTypes(
        string ProviderNamespace,
        ImmutableDictionary<string, ImmutableArray<string>> ResourceTypeByApiVersion)
    {
        public IReadOnlyDictionary<string, string> GetLatestApiVersionByType()
            => ResourceTypeByApiVersion
                .SelectMany(x => x.Value.Select(y => (type: y, version: x.Key)))
                .GroupBy(x => x.type, x => x.version, StringComparer.OrdinalIgnoreCase)
                .ToDictionary(x => x.Key, x => x.OrderByDescending(y => y, ApiVersionComparer.Instance).First(), StringComparer.OrdinalIgnoreCase);

        public IReadOnlyDictionary<string, ImmutableArray<string>> GetApiVersionsByType()
            => ResourceTypeByApiVersion
                .SelectMany(x => x.Value.Select(y => (type: y, version: x.Key)))
                .GroupBy(x => x.type, x => x.version, StringComparer.OrdinalIgnoreCase)
                .ToDictionary(x => x.Key, x => x.ToImmutableArray(), StringComparer.OrdinalIgnoreCase);

        public bool HasType(string resourceType, string apiVersion)
            => ResourceTypeByApiVersion.TryGetValue(apiVersion, out var types)
            && types.Contains(resourceType, StringComparer.OrdinalIgnoreCase);
    }

    public record GenerateResult(
        GroupedTypes GroupedTypes,
        ImmutableDictionary<string, string> FilesByPath);

    public record ResourceMetadata(
        string Provider,
        string ResourceType,
        string UnqualifiedResourceType,
        string ApiVersion,
        ResourceType Type,
        bool IsChildResource,
        bool IsParentTypeAvailable);

    public record NamedType(string Name, TypeBase Type);

    public IEnumerable<GroupedTypes> GetGroupedTypes()
    {
        var resourceTypesByProvider = typeProvider.GetResourceTypes()
            .GroupBy(x => Utils.GetProviderNamespace(x.resourceType), StringComparer.OrdinalIgnoreCase);

        foreach (var providerGroup in resourceTypesByProvider)
        {
            var providerNamespace = providerGroup.Key;
            var typesByApiVersion = providerGroup
                .GroupBy(x => x.apiVersion, StringComparer.OrdinalIgnoreCase)
                .ToImmutableDictionary(x => x.Key, x => x.Select(y => y.resourceType).ToImmutableArray(), StringComparer.OrdinalIgnoreCase);

            yield return new(providerNamespace, typesByApiVersion);
        }
    }

    public static IEnumerable<KeyValuePair<string, ObjectTypeProperty>> GetOrderedWritableProperties(IEnumerable<KeyValuePair<string, ObjectTypeProperty>> properties)
        => properties.Where(x => !x.Value.Flags.HasFlag(ObjectTypePropertyFlags.ReadOnly))
            .OrderBy(x => x.Key, StringComparer.OrdinalIgnoreCase);

    private static string GetHeading(ResourceMetadata resource, bool isLatestVersionPage)
    {
        var pageTitle = isLatestVersionPage ? resource.ResourceType : $"{resource.ResourceType} {resource.ApiVersion}";
        var apiVersion = isLatestVersionPage ? "latest" : resource.ApiVersion;

        return $"""
---
title: {pageTitle}
description: Azure {resource.ResourceType} syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version {apiVersion}
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
""";
    }

    private static string GetApiVersionLinks(GroupedTypes groupedTypes, ResourceMetadata resource, bool isLatestVersionPage)
    {
        var pathDepth = resource.UnqualifiedResourceType.Split('/').Length;
        if (isLatestVersionPage)
        {
            // The latest pages are one level higher than the other pages
            pathDepth--;
        }

        var pathPrefix = string.Concat(Enumerable.Repeat("../", pathDepth));

        var otherApiVersions = groupedTypes.ResourceTypeByApiVersion
            .Where(x => x.Value.Contains(resource.ResourceType, StringComparer.OrdinalIgnoreCase))
            .Where(x => !StringComparer.OrdinalIgnoreCase.Equals(resource.ApiVersion))
            .Select(x => x.Key)
            .OrderByDescending(x => x, ApiVersionComparer.Instance);
        
        var resourceTypePageName = resource.UnqualifiedResourceType.ToLowerInvariant();

        var sb = new StringBuilder();
        sb.Append($"""
> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest]({pathPrefix}{resourceTypePageName}.md)

""");

        foreach (var otherApiVersion in otherApiVersions)
        {
            var apiVersionLower = otherApiVersion.ToLowerInvariant();
        sb.Append($"""
> - [{apiVersionLower}]({pathPrefix}{apiVersionLower}/{resourceTypePageName}.md)

""");
        }

        return sb.ToString();
    }

    private static string GetResourceRemarks(ResourceMetadata resource, RemarksFile remarks)
    {
        var resourceRemarks = remarks.GetResourceRemarks(resource).ToArray();

        if (!resourceRemarks.Any())
        {
            return "";
        }

        var sb = new StringBuilder();
        sb.Append($"""
## Remarks


""");

        foreach (var resourceRemark in resourceRemarks)
        {
            sb.Append($"""
{resourceRemark.Description}


""");
        }

        return sb.ToString();
    }

    private static string? GetBicepQuickstartsSection(SamplesFile samples, ResourceMetadata resource)
    {
        var matchingLinks = samples.QuickstartLinks
            .Where(x => x.ResourceTypes.Contains(resource.ResourceType, StringComparer.OrdinalIgnoreCase))
            .Where(x => x.HasBicep)
            .OrderBy(x => x.Title).ToArray();

        if (!matchingLinks.Any())
        {
            return null;
        }

        var sb = new StringBuilder();
        sb.Append($"""
### Azure Quickstart Samples

The following {MarkdownUtils.GetLink("Azure Quickstart templates", "https://aka.ms/azqst")} contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |

""");
        foreach (var link in matchingLinks)
        {
            var bicepUrl = $"https://github.com/Azure/azure-quickstart-templates/tree/master/{link.Path}/main.bicep";
            var description = MarkdownUtils.ConvertDocsLinks(link.Description);

            sb.Append($"""
> | [{link.Title}]({bicepUrl}) | {MarkdownUtils.Escape(description)} |

""");
        }

        sb.AppendLine("");

        return sb.ToString();
    }

    private static string GetJsonQuickstartsSection(SamplesFile samples, ResourceMetadata resource)
    {
        var matchingLinks = samples.QuickstartLinks
            .Where(x => x.ResourceTypes.Contains(resource.ResourceType, StringComparer.OrdinalIgnoreCase))
            .OrderBy(x => x.Title).ToArray();

        if (!matchingLinks.Any())
        {
            return "";
        }

        var sb = new StringBuilder();
        sb.Append($"""
### Azure Quickstart Templates

The following {MarkdownUtils.GetLink("Azure Quickstart templates", "https://aka.ms/azqst")} deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |

""");
        foreach (var link in matchingLinks)
        {
            var templateUrl = $"https://github.com/Azure/azure-quickstart-templates/tree/master/{link.Path}";
            var rawTemplateUrl = $"https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/{link.Path}/azuredeploy.json";
            var deployUrl = $"https://portal.azure.com/#create/Microsoft.Template/uri/{Uri.EscapeDataString(rawTemplateUrl)}";
            var description = MarkdownUtils.ConvertDocsLinks(link.Description);

            sb.Append($"""
> | [{link.Title}]({templateUrl})<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)]({deployUrl}) | {MarkdownUtils.Escape(description)} |

""");
        }

        sb.AppendLine("");

        return sb.ToString();
    }

    private static string? GetAvmSection(SamplesFile samples, AvmLinkType linkType, ResourceMetadata resource)
    {
        var matchingLinks = samples.AvmLinks
            .Where(x => StringComparer.OrdinalIgnoreCase.Equals(x.ResourceType, resource.ResourceType))
            .Where(x => x.Type == linkType)
            .OrderBy(x => x.Title).ToArray();

        if (!matchingLinks.Any())
        {
            return null;
        }

        var sb = new StringBuilder();
        sb.Append($"""
### Azure Verified Modules

The following {MarkdownUtils.GetLink("Azure Verified Modules", "https://aka.ms/avm")} can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |

""");
        foreach (var link in matchingLinks)
        {
            var description = MarkdownUtils.ConvertDocsLinks(link.Description);

            sb.Append($"""
> | [{link.Title}]({link.RepoUrl}) | {MarkdownUtils.Escape(description)} |

""");
        }

        sb.AppendLine("");

        return sb.ToString();
    }

    private static string GetBicepZone(ConfigLoader configLoader, RemarksLoader remarksLoader, ResourceMetadata resource, ImmutableArray<NamedType> namedTypes, RemarksFile remarks, int anchorIndex)
    {
        var sb = new StringBuilder();
        sb.Append($"""
::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The {resource.UnqualifiedResourceType} resource type can be deployed with operations that target: 


""");

        if (Utils.HasWritableScope(resource.Type, ScopeType.Tenant))
        {
                    sb.Append($"""
* **Tenant** - See {MarkdownUtils.GetLink("tenant deployment commands", "/azure/azure-resource-manager/bicep/deploy-to-tenant")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ManagementGroup))
        {
                    sb.Append($"""
* **Management groups** - See {MarkdownUtils.GetLink("management group deployment commands", "/azure/azure-resource-manager/bicep/deploy-to-management-group")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.Subscription))
        {
                    sb.Append($"""
* **Subscription** - See {MarkdownUtils.GetLink("subscription deployment commands", "/azure/azure-resource-manager/bicep/deploy-to-subscription")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ResourceGroup))
        {
                    sb.Append($"""
* **Resource groups** - See {MarkdownUtils.GetLink("resource group deployment commands", "/azure/azure-resource-manager/bicep/deploy-to-resource-group")}
""");
        }

        var samples = CodeSampleGenerator.GetExample(resource, namedTypes, CodeSampleGenerator.Flavor.Bicep);

        sb.Append($"""


For a list of changed properties in each API version, see {MarkdownUtils.GetLink("change log", $"~/{resource.Provider.ToLowerInvariant()}/change-log/{resource.UnqualifiedResourceType.ToLowerInvariant()}.md")}.

## Resource format

To create a {resource.ResourceType} resource, add the following Bicep to your template.

```bicep
{samples.MainSample}
```

""");

        sb.Append(GetDeploymentRemarks(resource, remarks, DeploymentType.Bicep));

        foreach (var (discObjectType, discSamples) in samples.DiscrimatedSamples)
        {
            sb.Append($"""
### {discObjectType.Name} objects

Set the **{discObjectType.Discriminator}** property to specify the type of object.


""");

            foreach (var discSample in discSamples)
            {
                sb.Append($"""
For **{discSample.DiscriminatorValue}**, use:

```bicep
{discSample.Sample}
```


""");
            }
        }

        sb.Append(GenerateOptionalSection("Property Values", [
            GetPropertyValues(resource, DeploymentType.Bicep, namedTypes, remarks, anchorIndex),
        ]));

        sb.Append(GenerateOptionalSection("Usage Examples", [
            GetBicepSamplesSection(remarksLoader, resource, remarks),
            GetAvmSection(configLoader.GetSamples(), AvmLinkType.Bicep, resource),
            GetBicepQuickstartsSection(configLoader.GetSamples(), resource),
        ]));

        sb.Append($"""

::: zone-end

""");

        return sb.ToString();
    }

    private static string GenerateOptionalSection(string heading, string?[] sections)
    {
        var sb = new StringBuilder();

        if (!sections.Any(x => x is {}))
        {
            return "";
        }

        sb.Append($"""
## {heading}

""");

        foreach (var section in sections)
        {
            if (section is {})
            {
                sb.Append(section);
            }
        }

        return sb.ToString();
    }


    private static string GetArmTemplateZone(ConfigLoader configLoader, ResourceMetadata resource, ImmutableArray<NamedType> namedTypes, RemarksFile remarks, int anchorIndex)
    {
        var sb = new StringBuilder();
        sb.Append($"""
::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The {resource.UnqualifiedResourceType} resource type can be deployed with operations that target: 


""");

        if (Utils.HasWritableScope(resource.Type, ScopeType.Tenant))
        {
                    sb.Append($"""
* **Tenant** - See {MarkdownUtils.GetLink("tenant deployment commands", "/azure/azure-resource-manager/templates/deploy-to-tenant")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ManagementGroup))
        {
                    sb.Append($"""
* **Management groups** - See {MarkdownUtils.GetLink("management group deployment commands", "/azure/azure-resource-manager/templates/deploy-to-management-group")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.Subscription))
        {
                    sb.Append($"""
* **Subscription** - See {MarkdownUtils.GetLink("subscription deployment commands", "/azure/azure-resource-manager/templates/deploy-to-subscription")}
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ResourceGroup))
        {
                    sb.Append($"""
* **Resource groups** - See {MarkdownUtils.GetLink("resource group deployment commands", "/azure/azure-resource-manager/templates/deploy-to-resource-group")}
""");
        }

        var samples = CodeSampleGenerator.GetExample(resource, namedTypes, CodeSampleGenerator.Flavor.Json);

        sb.Append($"""


For a list of changed properties in each API version, see {MarkdownUtils.GetLink("change log", $"~/{resource.Provider.ToLowerInvariant()}/change-log/{resource.UnqualifiedResourceType.ToLowerInvariant()}.md")}.

## Resource format

To create a {resource.ResourceType} resource, add the following JSON to your template.

```json
{samples.MainSample}
```

""");

        sb.Append(GetDeploymentRemarks(resource, remarks, DeploymentType.Json));

        foreach (var (discObjectType, discSamples) in samples.DiscrimatedSamples)
        {
            sb.Append($"""
### {discObjectType.Name} objects

Set the **{discObjectType.Discriminator}** property to specify the type of object.


""");

            foreach (var discSample in discSamples)
            {
                sb.Append($"""
For **{discSample.DiscriminatorValue}**, use:

```json
{discSample.Sample}
```


""");
            }
        }

        sb.Append(GenerateOptionalSection("Property Values", [
            GetPropertyValues(resource, DeploymentType.Json, namedTypes, remarks, anchorIndex),
        ]));

        sb.Append(GenerateOptionalSection("Usage Examples", [
            GetJsonQuickstartsSection(configLoader.GetSamples(), resource),
        ]));

        sb.Append($"""

::: zone-end

""");

        return sb.ToString();
    }

    private static string GetTerraformZone(ConfigLoader configLoader, RemarksLoader remarksLoader, ResourceMetadata resource, ImmutableArray<NamedType> namedTypes, RemarksFile remarks, int anchorIndex)
    {
        var sb = new StringBuilder();
        sb.Append($"""
::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The {resource.UnqualifiedResourceType} resource type can be deployed with operations that target: 


""");

        if (Utils.HasWritableScope(resource.Type, ScopeType.Tenant))
        {
                    sb.Append($"""
* **Tenant**
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ManagementGroup))
        {
                    sb.Append($"""
* **Management groups**
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.Subscription))
        {
                    sb.Append($"""
* **Subscription**
""");
        }

        if (Utils.HasWritableScope(resource.Type, ScopeType.ResourceGroup))
        {
                    sb.Append($"""
* **Resource groups**
""");
        }

        var samples = CodeSampleGenerator.GetExample(resource, namedTypes, CodeSampleGenerator.Flavor.Terraform);

        sb.Append($"""


For a list of changed properties in each API version, see {MarkdownUtils.GetLink("change log", $"~/{resource.Provider.ToLowerInvariant()}/change-log/{resource.UnqualifiedResourceType.ToLowerInvariant()}.md")}.

## Resource format

To create a {resource.ResourceType} resource, add the following Terraform to your template.

```terraform
{samples.MainSample}
```

""");

        sb.Append(GetDeploymentRemarks(resource, remarks, DeploymentType.Terraform));

        foreach (var (discObjectType, discSamples) in samples.DiscrimatedSamples)
        {
            sb.Append($"""
### {discObjectType.Name} objects

Set the **{discObjectType.Discriminator}** property to specify the type of object.


""");

            foreach (var discSample in discSamples)
            {
                sb.Append($"""
For **{discSample.DiscriminatorValue}**, use:

```terraform
{discSample.Sample}
```


""");
            }
        }

        sb.Append(GenerateOptionalSection("Property Values", [
            GetPropertyValues(resource, DeploymentType.Terraform, namedTypes, remarks, anchorIndex),
        ]));

        sb.Append(GenerateOptionalSection("Usage Examples", [
            GetTerraformSamplesSection(remarksLoader, resource, remarks),
            GetAvmSection(configLoader.GetSamples(), AvmLinkType.Terraform, resource),
        ]));

        sb.Append($"""

::: zone-end

""");

        return sb.ToString();
    }

    private static string? GetBicepSamplesSection(RemarksLoader remarksLoader, ResourceMetadata resource, RemarksFile remarks)
    {
        var samples = remarks.GetBicepSamples(resource).ToArray();

        if (!samples.Any())
        {
            return null;
        }

        var sb = new StringBuilder();
        sb.Append($"""
### Bicep Samples


""");
        
        foreach (var sample in samples)
        {
            sb.Append($"""
{sample.Description}

```bicep
{remarksLoader.GetCodeSample(resource.Provider, sample)}
```

""");
        }

        return sb.ToString();
    }

    private static string? GetTerraformSamplesSection(RemarksLoader remarksLoader, ResourceMetadata resource, RemarksFile remarks)
    {
        var samples = remarks.GetTerraformSamples(resource).ToArray();

        if (!samples.Any())
        {
            return null;
        }

        var sb = new StringBuilder();
        sb.Append($"""
### Terraform Samples


""");

        foreach (var sample in samples)
        {
            sb.Append($"""
{sample.Description}

```terraform
{remarksLoader.GetCodeSample(resource.Provider, sample)}
```

""");
        }

        return sb.ToString();
    }

    private static string GetDeploymentRemarks(ResourceMetadata resource, RemarksFile remarks, DeploymentType deploymentType)
    {
        var sb = new StringBuilder();
        
        foreach (var deploymentRemark in remarks.GetDeploymentRemarks(resource, deploymentType))
        {
            sb.Append($"""
> [!NOTE]
> {deploymentRemark.Description}


""");
        }

        return sb.ToString();
    }

    private static ImmutableArray<NamedType> GetNamedTypes(ResourceMetadata resource)
    {
        HashSet<TypeBase> visited = new();
        Queue<TypeBase> queue = new();
        List<NamedType> namedTypes = new();

        queue.Enqueue(resource.Type);

        while (queue.Any())
        {
            var type = queue.Dequeue();
            if (visited.Contains(type))
            {
                continue;
            }
            visited.Add(type);

            switch (type)
            {
                case ResourceType resourceType:
                    queue.Enqueue(resourceType.Body.Type);
                    break;

                case ObjectType objectType:
                    namedTypes.Add(new(objectType.Name, type));
                    foreach (var (_, prop) in GetOrderedWritableProperties(objectType.Properties))
                    {
                        queue.Enqueue(prop.Type.Type);
                    }
                    if (objectType.AdditionalProperties != null)
                    {
                        queue.Enqueue(objectType.AdditionalProperties.Type);
                    }
                    break;
                case DiscriminatedObjectType discObjectType:
                    namedTypes.Add(new(discObjectType.Name, type));
                    foreach (var (_, prop) in GetOrderedWritableProperties(discObjectType.BaseProperties))
                    {
                        queue.Enqueue(prop.Type.Type);
                    }
                    foreach (var element in discObjectType.Elements.Values)
                    {
                        queue.Enqueue(element.Type);
                    }
                    break;
                case ArrayType arrayType:
                    if (arrayType.ItemType != null)
                    {
                        queue.Enqueue(arrayType.ItemType.Type);
                    }
                    break;
                case UnionType unionType:
                    foreach (var element in unionType.Elements)
                    {
                        queue.Enqueue(element.Type);
                    }
                    break;                
            }
        }

        return [.. namedTypes];
    }

    private static string Br => "<br />";

    private static string JoinWithBr(IEnumerable<string> values)
        => string.Join(Br, values);

    private static string JoinWithBr(params string[] values)
        => JoinWithBr(values as IEnumerable<string>);

    private static string GetTypeValue(TypeBase type, int anchorIndex)
    {
        switch (type)
        {
            case UnionType unionType when unionType.Elements.Select(x => x.Type).OfType<StringLiteralType>() is {} elements:
                return JoinWithBr(elements.Select(GetTypeValue).OrderBy(x => x, StringComparer.OrdinalIgnoreCase));
            case StringLiteralType stringLiteral:
                return $"'{stringLiteral.Value}'";
            case IntegerType intType:
                var intConstraints = GetConstraintText(intType);
                return $"int{intConstraints}";
            case BooleanType:
                return "bool";
            case AnyType anyType:
                return "any";
            case StringType stringType:
                var stringConstraints = GetConstraintText(stringType);
                return $"string{stringConstraints}";
            case ObjectType objectType:
                var anchorSuffixO = anchorIndex > 0 ? $"-{anchorIndex}" : "";
                return MarkdownUtils.GetLink(objectType.Name, MarkdownUtils.GetDocAnchor($"{objectType.Name}{anchorSuffixO}"));
            case DiscriminatedObjectType objectType:
                var anchorSuffixDo = anchorIndex > 0 ? $"-{anchorIndex}" : "";
                return MarkdownUtils.GetLink(objectType.Name, MarkdownUtils.GetDocAnchor($"{objectType.Name}{anchorSuffixDo}"));
            case ArrayType arrayType when arrayType.ItemType.Type is UnionType:
                return $"String array containing any of:{Br}{GetTypeValue(arrayType.ItemType.Type, anchorIndex)}";
            case ArrayType arrayType:
                return $"{GetTypeValue(arrayType.ItemType.Type, anchorIndex)}[]";
            default:
                throw new NotImplementedException($"Type {type.GetType()} not implemented");
        }
    }

    private static string GetConstraintText(StringType stringType)
    {
        var constraints = new List<string>();
        
        if (stringType.MinLength is not null)
        {
            constraints.Add($"Min length = {stringType.MinLength}");
        }
        if (stringType.MaxLength is not null)
        {
            constraints.Add($"Max length = {stringType.MaxLength}");
        }
        if (stringType.Sensitive is true)
        {
            constraints.Add($"Sensitive value. Pass in as a secure parameter.");
        }
        if (stringType.Pattern is not null)
        {
            constraints.Add($"Pattern = `{stringType.Pattern}`");
        }

        return constraints.Any() ? $" {Br}{Br}" + JoinWithBr("Constraints:", JoinWithBr(constraints)) : "";
    }

    private static string GetConstraintText(IntegerType intType)
    {
        var constraints = new List<string>();
        
        if (intType.MinValue is not null)
        {
            constraints.Add($"Min value = {intType.MinValue}");
        }
        if (intType.MaxValue is not null)
        {
            constraints.Add($"Max value = {intType.MaxValue}");
        }

        return constraints.Any() ? $" {Br}{Br}" + JoinWithBr("Constraints:", JoinWithBr(constraints)) : "";
    }

    private record PropertyData(
        string Name,
        string? Description,
        string Type);

    private static IEnumerable<PropertyData> GetProperties(
        ResourceMetadata resource,
        DeploymentType deploymentType,
        string typeName,
        IReadOnlyDictionary<string, ObjectTypeProperty> properties,
        IEnumerable<PropertyRemark> propertyRemarks,
        int anchorIndex)
    {
        var remarksByPropertyName = propertyRemarks.ToDictionary(x => x.PropertyName, StringComparer.OrdinalIgnoreCase);
        var isResourceType = (typeName == resource.ResourceType);

        if (isResourceType)
        {
            switch (deploymentType)
            {
                case DeploymentType.Bicep:
                    if (Utils.IsChildResource(resource.UnqualifiedResourceType))
                    {
                        var parentType = Utils.GetParentResource(resource.ResourceType);
                        var parentTypeUnqualified = Utils.GetParentResource(resource.UnqualifiedResourceType);

                        yield return new(
                            "parent",
                            $"In Bicep, you can specify the parent resource for a child resource. You only need to add this property when the child resource is declared outside of the parent resource.{Br}{Br}For more information, see {MarkdownUtils.GetLink("Child resource outside parent resource", "/azure/azure-resource-manager/bicep/child-resource-name-type#outside-parent-resource")}.",
                            $"Symbolic name for resource of type: {GetParentResourceNameWithOptionalLink(resource)}");
                    }
                    else if (Utils.HasWritableScope(resource.Type, ScopeType.Extension))
                    {
                        yield return new(
                            "scope",
                            "Use when creating a resource at a scope that is different than the deployment scope.",
                            $"Set this property to the symbolic name of a resource to apply the {MarkdownUtils.GetLink("extension resource", "/azure/azure-resource-manager/bicep/scope-extension-resources")}.");
                    }
                    break;
                case DeploymentType.Terraform:
                    if (Utils.IsChildResource(resource.UnqualifiedResourceType))
                    {
                        var parentType = Utils.GetParentResource(resource.ResourceType);
                        var parentTypeUnqualified = Utils.GetParentResource(resource.UnqualifiedResourceType);

                        yield return new(
                            "parent_id",
                            $"The ID of the resource that is the parent for this resource.",
                            $"ID for resource of type: {GetParentResourceNameWithOptionalLink(resource)}");
                    }
                    else if (Utils.HasWritableScope(resource.Type, ScopeType.Extension))
                    {
                        yield return new(
                            "parent_id",
                            "The ID of the resource to apply this extension resource to.",
                            "string (required)");
                    }

                    yield return new(
                        "type",
                        "The resource type",
                        $"\"{resource.ResourceType}@{resource.ApiVersion}\"");
                    break;
                case DeploymentType.Json:
                    yield return new(
                        "type",
                        "The resource type",
                        $"'{resource.ResourceType}'");
                    yield return new(
                        "apiVersion",
                        "The api version",
                        $"'{resource.ApiVersion}'");
                    break;
            }
        }

        foreach (var (propName, prop) in GetOrderedWritableProperties(properties))
        {
            if (isResourceType && propName == "tags")
            {
                var tagsType = deploymentType != DeploymentType.Terraform ?
                    $"Dictionary of tag names and values. See {MarkdownUtils.GetLink("Tags in templates", "/azure/azure-resource-manager/management/tag-resources#arm-templates")}" :
                    "Dictionary of tag names and values.";

                yield return new(
                    "tags",
                    "Resource tags",
                    tagsType);
                continue;
            }

            var remark = remarksByPropertyName.TryGetValue(propName, out var value) ? value : null;
            var description = remark?.Description ?? prop.Description;
            var requiredSuffix = prop.Flags.HasFlag(ObjectTypePropertyFlags.Required) ? " (required)" : "";

            yield return new(
                propName,
                description,
                $"{GetTypeValue(prop.Type.Type, anchorIndex)}{requiredSuffix}");
        }
    }

    public static string GetPropertyValues(ResourceMetadata resource, DeploymentType deploymentType, ImmutableArray<NamedType> namedTypes, RemarksFile remarks, int anchorIndex)
    {
        var anchorSuffix = anchorIndex > 0 ? $"-{anchorIndex}" : "";
        var remarksByObjectName = remarks.GetPropertyRemarks(resource).ToLookup(x => x.ObjectName, StringComparer.OrdinalIgnoreCase);

        var sb = new StringBuilder();
        void writeHeading(string name) {
                    sb.Append($"""
### {name}

| Name | Description | Value |
| ---- | ----------- | ------------ |

""");
        }

        void writeProperties(string typeName, IReadOnlyDictionary<string, ObjectTypeProperty> properties) {
            var remarksByPropertyName = remarksByObjectName[typeName]
                .ToDictionary(x => x.PropertyName, StringComparer.OrdinalIgnoreCase);

            var propertyData = GetProperties(resource, deploymentType, typeName, properties, remarksByObjectName[typeName], anchorIndex)
                .OrderBy(x => x.Name, StringComparer.OrdinalIgnoreCase);

            foreach (var property in propertyData)
            {
                var description = MarkdownUtils.ConvertDocsLinks(property.Description ?? "");

                sb.Append($"""
| {property.Name} | {MarkdownUtils.Escape(description)} | {property.Type} |

""");
            }
        }

        foreach (var (name, type) in GetOrderedTypes(resource, namedTypes))
        {
            switch (type)
            {
                case ObjectType objectType: {
                    writeHeading(name);
                    writeProperties(name, objectType.Properties);
                    sb.AppendLine("");
                    break;
                }
                case DiscriminatedObjectType discType: {
                    var typeLookup = discType.Elements
                        .ToDictionary(x => x.Key, x => (x.Value.Type as ObjectType)!);


                    if (typeLookup.Values.Any(x => x is null))
                    {
                        throw new InvalidOperationException($"Expected all discriminated elements to be objects");
                    }

                    var discriminatorProperty = new ObjectTypeProperty(
                        new StaticTypeReference(new UnionType(discType.Elements.Keys
                            .Select(x => new StaticTypeReference(new StringLiteralType(x)))
                            .ToList())),
                        ObjectTypePropertyFlags.Required,
                        string.Join(' ', typeLookup.Select(x => $"Set to '{x.Key}' for type {MarkdownUtils.GetLink(x.Value.Name, MarkdownUtils.GetDocAnchor($"{x.Value.Name}{anchorSuffix}"))}.")));

                    writeHeading(name);
                    writeProperties(name, discType.BaseProperties.ToImmutableDictionary().Add(discType.Discriminator, discriminatorProperty));
                    sb.AppendLine("");
                    break;
                }
            }
            
        }

        return sb.ToString();
    }

    public static IEnumerable<NamedType> GetOrderedTypes(ResourceMetadata resource, ImmutableArray<NamedType> namedTypes)
        => namedTypes
            // We want to order top-level resource properties above all other types
            .OrderBy(x => x.Name == resource.ResourceType ? 0 : 1)
            .ThenBy(x => x.Name, StringComparer.OrdinalIgnoreCase);

    public static string GenerateMarkdown(GroupedTypes groupedTypes, ResourceType resourceType, ConfigLoader configLoader, RemarksLoader remarksLoader, bool isLatestVersionPage)
    {
        var resourceTypeName = resourceType.Name.Split('@')[0];
        var apiVersion = resourceType.Name.Split('@')[1];
        var providerNamespace = Utils.GetProviderNamespace(resourceTypeName);
        var unqualifiedResourceType = Utils.GetUnqualifiedType(resourceTypeName);
        var isChildResource = Utils.IsChildResource(unqualifiedResourceType);
        var isParentTypeAvailable = isChildResource && groupedTypes.HasType(Utils.GetParentResource(resourceTypeName), apiVersion);

        var resource = new ResourceMetadata(
            Provider: providerNamespace,
            ResourceType: resourceTypeName,
            UnqualifiedResourceType: unqualifiedResourceType,
            ApiVersion: apiVersion,
            Type: resourceType,
            IsChildResource: isChildResource,
            IsParentTypeAvailable: isParentTypeAvailable);

        var namedTypes = GetNamedTypes(resource);
        var remarks = remarksLoader.GetRemarks(providerNamespace);
        var pageTitle = isLatestVersionPage ? $"{resource.Provider} {resource.UnqualifiedResourceType}" : $"{resource.Provider} {resource.UnqualifiedResourceType} {resource.ApiVersion}";

        return $"""
{GetHeading(resource, isLatestVersionPage)}
# {pageTitle}

{GetApiVersionLinks(groupedTypes, resource, isLatestVersionPage)}
{GetResourceRemarks(resource, remarks)}
{GetBicepZone(configLoader, remarksLoader, resource, namedTypes, remarks, 0)}
{GetArmTemplateZone(configLoader, resource, namedTypes, remarks, 1)}
{GetTerraformZone(configLoader, remarksLoader, resource, namedTypes, remarks, 2)}
""";
    }

    private static string GetParentResourceNameWithOptionalLink(ResourceMetadata resource)
    {
        if (!resource.IsChildResource)
        {
            throw new InvalidOperationException($"Resource {resource.ResourceType} is not a child resource");
        }

        var parentType = Utils.GetParentResource(resource.ResourceType);
        var parentTypeUnqualified = Utils.GetParentResource(resource.UnqualifiedResourceType);

        return resource.IsParentTypeAvailable ?
            MarkdownUtils.GetLink(parentTypeUnqualified, $"~/{parentType.ToLowerInvariant()}.md") :
            parentTypeUnqualified;
    }
}