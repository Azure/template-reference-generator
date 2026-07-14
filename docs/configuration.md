# Configuration

There are various configuration files that can be used to customize the behavior for the generator. This page explains where to find them and how to use them.

The configuration files all have JSON schemas associated with them. Open them with an IDE like VSCode to get real-time validation.

## Samples

This file can be found under [settings/samples/samples.json](../settings/samples/samples.json). It is used to configure the generation process to include links to external code samples for different resource types. The schema is available [here](../settings/samples.schema.json).

`samples.json` is not manually maintained. It can be updated by running [scripts/UpdateSamples.ps1](../scripts/UpdateSamples.ps1).

> [!NOTE]
> This process is not currently automated. The script needs to be re-run to pick up the latest set of samples.

## Config

This file can be found under [settings/config/config.json](../settings/config/config.json), and can be used to configure the generation process. The schema is available [here](../settings/config.schema.json).

`config.json` contains central config for:
* `TocTitleMapping`: used to generate custom page titles for different resource provider namespaces.
* `ExcludedProviders`: a list of provider namespaces that should be excluded from docs generation.

## Remarks

These set of files can be found under [settings/remarks/<provider_namespace>/remarks.json](../settings/remarks/<provider_namespace>/remarks.json), and can be used to add customizations to different doc pages. The schema is available [here](../settings/remarks.schema.json).

For example, [remarks/microsoft.resources/remarks.json](../settings/remarks/microsoft.resources/remarks.json) can be used to customize documents for the Microsoft.Resources provider namespace.

`remarks.json` contains the following configuration options:
* `DeploymentRemarks`: Can be used to add custom markdown with information on deploying a particular resource type. For example, explaining some of the quirks.
* `ResourceRemarks`: Can be used to add custom remarks in markdown format about a particular resource type. See [here](https://github.com/Azure/bicep-refdocs-generator/blob/016143aa9375ba0ce62255fed1fad8905cfe75bf/src/TemplateRefGenerator.Tests/Files/markdown/microsoft.keyvault/2023-07-01/vaults.md?plain=1#L29-L35) for an example of what the customized output looks like.
* `PropertyRemarks`: Can be used to replace the description markdown for a particular resource type property.
* `BicepSamples`: A list of `.bicep` files that will be added as samples to documentation. See [here](https://github.com/Azure/bicep-refdocs-generator/blob/016143aa9375ba0ce62255fed1fad8905cfe75bf/src/TemplateRefGenerator.Tests/Files/markdown/microsoft.resources/2024-07-01/resourcegroups.md?plain=1#L61-L75) for an example of what the customized looks like.
* `ArmTemplateSamples`: A list of ARM template `.json` files that will be added as samples to documentation.
* `TerraformSamples`: A list of `.tf` files that will be added as samples to documentation.