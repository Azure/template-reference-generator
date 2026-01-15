// Copyright (c) Microsoft Corporation.
// Licensed under the MIT License.

using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.ComponentModel;
using System.Data.Common;
using System.Linq;
using System.Text;
using Azure.Bicep.Types;
using Azure.Bicep.Types.Concrete;

namespace TemplateRefGenerator;

public class CodeSampleGenerator
{
    public enum Flavor
    {
        Bicep,
        Json,
        Terraform,
    }

    public record DiscriminatedObjectSample(
        string Sample,
        string DiscriminatorValue);

    public record GenerateResult(
        string MainSample,
        ImmutableDictionary<DiscriminatedObjectType, ImmutableArray<DiscriminatedObjectSample>> DiscrimatedSamples);

    public static GenerateResult GetExample(MarkdownGenerator.ResourceMetadata resource, ImmutableArray<MarkdownGenerator.NamedType> namedTypes, Flavor flavor)
    {
        return flavor switch
        {
            Flavor.Bicep => GenerateBicep(resource, namedTypes),
            Flavor.Json => GenerateArmTemplateJson(resource, namedTypes),
            Flavor.Terraform => GenerateTerraform(resource, namedTypes),
            _ => throw new NotImplementedException(),
        };
    }

    private static string GetIndent(int indentLevel)
        => indentLevel > 0 ? string.Join("", Enumerable.Repeat("  ", indentLevel)) : "";

    private static string GetStringBuilderResult(Action<StringBuilder> action)
    {
        var sb = new StringBuilder();
        action(sb);
        return sb.ToString();
    }

    private static GenerateResult GenerateBicep(MarkdownGenerator.ResourceMetadata resource, ImmutableArray<MarkdownGenerator.NamedType> namedTypes)
    {
        var mainSample = GetStringBuilderResult(sb => GenerateBicep(resource, sb, 0, resource.Type, "", new()));

        var discriminatedSamples = new Dictionary<DiscriminatedObjectType, ImmutableArray<DiscriminatedObjectSample>>();
        foreach (var discriminatedObject in namedTypes.Select(x => x.Type).OfType<DiscriminatedObjectType>())
        {
            var samples = new List<DiscriminatedObjectSample>();
            foreach (var element in discriminatedObject.Elements)
            {
                var discSample = GetStringBuilderResult(sb => GenerateBicep(resource, sb, 0, element.Value.Type, null, new()));
                samples.Add(new(discSample, element.Key));
            }

            discriminatedSamples[discriminatedObject] = [.. samples];
        }

        return new(mainSample, discriminatedSamples.ToImmutableDictionary());
    }

    private static void GenerateBicep(MarkdownGenerator.ResourceMetadata resource, StringBuilder sb, int indentLevel, TypeBase type, string? path, HashSet<TypeBase> visited)
    {
        var indent = GetIndent(indentLevel);
        var propIndent = GetIndent(indentLevel + 1);

        if (visited.Contains(type))
        {
            // to avoid infinite recursion, exit early
            sb.Append($"...");
            return;
        }

        visited.Add(type);

        void AddProperty(string name, Action writeValue)
        {
            sb.Append($"{propIndent}{name}: ");
            writeValue();
            sb.AppendLine();
        }

        switch (type)
        {
            case ResourceType resourceType:
                sb.Append($"resource symbolicname '{resourceType.Name}' = ");
                GenerateBicep(resource, sb, 0, resourceType.Body.Type, "", visited);
                break;

            case ObjectType objectType:
                var props = MarkdownGenerator.GetOrderedWritableProperties(objectType.Properties).ToArray();
                var additionalPropType = objectType.AdditionalProperties;

                if (!props.Any() && additionalPropType is null)
                {
                    sb.Append($"{{}}");
                    break;
                }

                sb.AppendLine("{");

                if (path == "")
                {
                    if (Utils.IsChildResource(resource.UnqualifiedResourceType))
                    {
                        AddProperty("parent", () => sb.Append($"resourceSymbolicName"));
                    }
                    else if (Utils.HasWritableScope(resource.Type, ScopeType.Extension))
                    {
                        AddProperty("scope", () => sb.Append($"resourceSymbolicName or scope"));
                    }
                }

                foreach (var (name, prop) in MarkdownGenerator.GetOrderedWritableProperties(objectType.Properties))
                {
                    AddProperty(name, () => GenerateBicep(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited));
                }
                if (!props.Any() && additionalPropType is {})
                {
                    AddProperty("{customized property}", () => GenerateBicep(resource, sb, indentLevel + 1, additionalPropType.Type, $"{path}.*", visited));
                }
                sb.Append(indent + "}");
                break;
            case ArrayType arrayType:
                sb.AppendLine("[");
                sb.Append(propIndent);
                GenerateBicep(resource, sb, indentLevel + 1, arrayType.ItemType.Type, $"{path}[*]", visited);
                sb.AppendLine();
                sb.Append(indent + "]");
                break;
            case StringLiteralType stringLiteralType:
                sb.Append($"'{stringLiteralType.Value}'");
                break;
            case IntegerType:
                sb.Append($"int");
                break;
            case BooleanType:
                sb.Append($"bool");
                break;
            case StringType:
            case UnionType:
                sb.Append($"'string'");
                break;
            case DiscriminatedObjectType objectType:
                sb.AppendLine("{");
                foreach (var (name, prop) in MarkdownGenerator.GetOrderedWritableProperties(objectType.BaseProperties))
                {
                    sb.Append($"{propIndent}{name}: ");
                    GenerateBicep(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited);
                    sb.AppendLine();
                }
                sb.AppendLine($"{propIndent}{objectType.Discriminator}: 'string'");
                sb.AppendLine($"{propIndent}// For remaining properties, see {objectType.Name} objects");
                sb.Append(indent + "}");
                break;
            default:
                sb.Append($"any(...)");
                break;
        }

        visited.Remove(type);
    }

    private static GenerateResult GenerateArmTemplateJson(MarkdownGenerator.ResourceMetadata resource, ImmutableArray<MarkdownGenerator.NamedType> namedTypes)
    {
        var mainSample = GetStringBuilderResult(sb => GenerateArmTemplateJson(resource, sb, 0, resource.Type, "", new()));

        var discriminatedSamples = new Dictionary<DiscriminatedObjectType, ImmutableArray<DiscriminatedObjectSample>>();
        foreach (var discriminatedObject in namedTypes.Select(x => x.Type).OfType<DiscriminatedObjectType>())
        {
            var samples = new List<DiscriminatedObjectSample>();
            foreach (var element in discriminatedObject.Elements)
            {
                var discSample = GetStringBuilderResult(sb => GenerateArmTemplateJson(resource, sb, 0, element.Value.Type, null, new()));
                samples.Add(new(discSample, element.Key));
            }

            discriminatedSamples[discriminatedObject] = [.. samples];
        }

        return new(mainSample, discriminatedSamples.ToImmutableDictionary());
    }

    private static void GenerateArmTemplateJson(MarkdownGenerator.ResourceMetadata resource, StringBuilder sb, int indentLevel, TypeBase type, string? path, HashSet<TypeBase> visited)
    {
        if (visited.Contains(type))
        {
            // to avoid infinite recursion, exit early
            sb.Append($"...");
            return;
        }

        visited.Add(type);

        var indent = GetIndent(indentLevel);
        var propIndent = GetIndent(indentLevel + 1);

        void AddProperty(string name, bool isLast, Action writeValue)
        {
            sb.Append($"{propIndent}\"{name}\": ");
            writeValue();
            if (!isLast)
            {
                sb.Append($",");
            }
            sb.AppendLine();
        }

        switch (type)
        {
            case ResourceType resourceType:
                GenerateArmTemplateJson(resource, sb, indentLevel, resourceType.Body.Type, "", visited);
                break;

            case ObjectType objectType:
                var props = MarkdownGenerator.GetOrderedWritableProperties(objectType.Properties).ToList();
                var additionalPropType = objectType.AdditionalProperties;
                
                sb.AppendLine("{");
                if (path == "")
                {
                    if (props.FirstOrDefault(x => x.Key == "name") is {} nameProp)
                    {
                        props.Remove(nameProp);
                    }
                    AddProperty("type", false, () => sb.Append($"\"{resource.ResourceType}\""));
                    AddProperty("apiVersion", false, () => sb.Append($"\"{resource.ApiVersion}\""));
                    AddProperty("name", !props.Any(), () => sb.Append($"\"string\""));
                }

                for (var i = 0; i < props.Count; i++)
                {
                    var (name, prop) = props[i];
                    AddProperty(name, i >= props.Count - 1, () => GenerateArmTemplateJson(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited));
                }
                if (!props.Any() && additionalPropType is {})
                {
                    AddProperty("{customized property}", true, () => GenerateArmTemplateJson(resource, sb, indentLevel + 1, additionalPropType.Type, $"{path}.*", visited));
                }
                sb.Append(indent + "}");
                break;
            case ArrayType arrayType:
                if (arrayType.ItemType.Type is ObjectType or ArrayType)
                {
                    sb.AppendLine("[");
                    sb.Append(propIndent);
                    GenerateArmTemplateJson(resource, sb, indentLevel + 1, arrayType.ItemType.Type, $"{path}[*]", visited);
                    sb.AppendLine();
                    sb.Append(indent + "]");
                }
                else
                {
                    sb.Append("[ ");
                    GenerateArmTemplateJson(resource, sb, indentLevel, arrayType.ItemType.Type, $"{path}[*]", visited);
                    sb.Append(" ]");
                }
                break;
            case StringLiteralType stringLiteralType:
                sb.Append($"\"{stringLiteralType.Value}\"");
                break;
            case IntegerType:
                sb.Append($"\"int\"");
                break;
            case BooleanType:
                sb.Append($"\"bool\"");
                break;
            case StringType:
            case UnionType:
                sb.Append($"\"string\"");
                break;
            case DiscriminatedObjectType objectType:
                sb.AppendLine("{");
                foreach (var (name, prop) in MarkdownGenerator.GetOrderedWritableProperties(objectType.BaseProperties))
                {
                    AddProperty(name, false, () => GenerateArmTemplateJson(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited));
                }
                
                AddProperty(objectType.Discriminator, true, () => sb.Append($"\"string\""));
                sb.AppendLine($"{propIndent}// For remaining properties, see {objectType.Name} objects");
                sb.Append(indent + "}");
                break;
            default:
                sb.Append($"{{}}");
                break;
        }

        visited.Remove(type);
    }

    private static GenerateResult GenerateTerraform(MarkdownGenerator.ResourceMetadata resource, ImmutableArray<MarkdownGenerator.NamedType> namedTypes)
    {
        var mainSample = GetStringBuilderResult(sb => GenerateTerraform(resource, sb, 0, resource.Type, "", new()));

        var discriminatedSamples = new Dictionary<DiscriminatedObjectType, ImmutableArray<DiscriminatedObjectSample>>();
        foreach (var discriminatedObject in namedTypes.Select(x => x.Type).OfType<DiscriminatedObjectType>())
        {
            var samples = new List<DiscriminatedObjectSample>();
            foreach (var element in discriminatedObject.Elements)
            {
                var discSample = GetStringBuilderResult(sb => GenerateTerraform(resource, sb, 0, element.Value.Type, null, new()));
                samples.Add(new(discSample, element.Key));
            }

            discriminatedSamples[discriminatedObject] = [.. samples];
        }

        return new(mainSample, discriminatedSamples.ToImmutableDictionary());
    }

    private static readonly HashSet<string> TerraformRootProperties = new(StringComparer.OrdinalIgnoreCase) { "location", "name", "tags", "identity"};
    private static void GenerateTerraform(MarkdownGenerator.ResourceMetadata resource, StringBuilder sb, int indentLevel, TypeBase type, string? path, HashSet<TypeBase> visited)
    {
        if (visited.Contains(type))
        {
            // to avoid infinite recursion, exit early
            sb.Append($"...");
            return;
        }

        visited.Add(type);

        var indent = GetIndent(indentLevel);
        var propIndent = GetIndent(indentLevel + 1);

        void AddProperty(string name, Action writeValue)
        {
            sb.Append($"{propIndent}{name} = ");
            writeValue();
            sb.AppendLine();
        }

        switch (type)
        {
            case ResourceType resourceType:
                sb.Append($"resource \"azapi_resource\" \"symbolicname\" ");
                GenerateTerraform(resource, sb, 0, resourceType.Body.Type, "", visited);
                break;

            case ObjectType objectType:
                var props = MarkdownGenerator.GetOrderedWritableProperties(objectType.Properties).ToList();
                var additionalPropType = objectType.AdditionalProperties;

                sb.AppendLine("{");
                if (path == "")
                {
                    if (props.FirstOrDefault(x => x.Key == "name") is {} nameProp)
                    {
                        props.Remove(nameProp);
                    }

                    AddProperty("type", () => sb.Append($"\"{resource.ResourceType}@{resource.ApiVersion}\""));
                    AddProperty("name", () => sb.Append($"\"string\""));

                    AddProperty("parent_id", () => sb.Append($"\"string\""));

                    if (props.FirstOrDefault(x => x.Key == "identity") is {} identityProp && identityProp.Key != null)
                    {
                        props.Remove(identityProp);
                        sb.AppendLine($"{propIndent}identity {{");
                        var nestedPropIndent = GetIndent(indentLevel + 2);
                        sb.AppendLine($"{nestedPropIndent}type = \"string\"");
                        sb.AppendLine($"{nestedPropIndent}identity_ids = [");
                        sb.AppendLine($"{nestedPropIndent}{GetIndent(1)}\"string\"");
                        sb.AppendLine($"{nestedPropIndent}]");
                        sb.AppendLine($"{propIndent}}}");
                    }
                }

                var bodyProps = props.Where(x => path == "" && !TerraformRootProperties.Contains(x.Key)).ToList();
                foreach (var (name, prop) in props.Except(bodyProps))
                {
                    AddProperty(name, () => GenerateTerraform(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited));
                }
                if (bodyProps.Any())
                {
                    AddProperty("body", () => {
                        sb.AppendLine("{");
                        foreach (var (name, prop) in bodyProps)
                        {
                            AddProperty($"  {name}", () => GenerateTerraform(resource, sb, indentLevel + 2, prop.Type.Type, $"{path}.{name}", visited));
                        }
                        sb.Append($"{propIndent}}}");
                    });
                }

                if (!props.Any() && additionalPropType is {})
                {
                    AddProperty("{customized property}", () => GenerateTerraform(resource, sb, indentLevel + 1, additionalPropType.Type, $"{path}.*", visited));
                }

                sb.Append(indent + "}");
                break;
            case ArrayType arrayType:
                sb.AppendLine("[");
                sb.Append(propIndent);
                GenerateTerraform(resource, sb, indentLevel + 1, arrayType.ItemType.Type, $"{path}[*]", visited);
                sb.AppendLine();
                sb.Append(indent + "]");
                break;
            case StringLiteralType stringLiteralType:
                sb.Append($"\"{stringLiteralType.Value}\"");
                break;
            case IntegerType:
                sb.Append($"int");
                break;
            case BooleanType:
                sb.Append($"bool");
                break;
            case StringType:
            case UnionType:
                sb.Append($"\"string\"");
                break;
            case DiscriminatedObjectType objectType:
                sb.AppendLine("{");
                foreach (var (name, prop) in MarkdownGenerator.GetOrderedWritableProperties(objectType.BaseProperties))
                {
                    AddProperty(name, () => GenerateTerraform(resource, sb, indentLevel + 1, prop.Type.Type, $"{path}.{name}", visited));
                }
                
                AddProperty(objectType.Discriminator, () => sb.Append($"\"string\""));
                sb.AppendLine($"{propIndent}// For remaining properties, see {objectType.Name} objects");
                sb.Append(indent + "}");
                break;
            default:
                sb.Append($"?");
                break;
        }

        visited.Remove(type);
    }
}