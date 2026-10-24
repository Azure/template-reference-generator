# Developer Guide

## Accessing Generated Files

Every push to the `main` branch on this repo will trigger the [Generate GitHub Action](https://github.com/Azure/bicep-refdocs-generator/actions/workflows/generate.yml) which will run generation and upload results as an artifact named "generated".

Download this artifact (see [here](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-workflow-runs/downloading-workflow-artifacts) for info), and unzip it. This will give you the full generated docs folder structure.

You can also trigger the Generate action to run on demand (see [here](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-workflow-runs/manually-running-a-workflow) for info) to force generation with the most up-to-date copy of [bicep-types-az](https://github.com/Azure/bicep-types-az).

## Development

### Debugging

In VSCode, use the "Launch CLI" debug target to start the application in debug mode.

### Running tests

Run `dotnet test` to run the test suite.

### Updating baselines

If a test failure requires updating the baselines, follow the instructions and run the commands supplied in the error message.

If you want to update all of the baselines in one go, run:
```sh
./scripts/update_baselines.sh
```

### Building

Run `dotnet build` to build this project.

## Using the CLI

After building the .NET solution, you can use the CLI by running:

```sh
./src/TemplateRefGenerator/bin/Debug/net10.0/TemplateRefGenerator
```

If you run this command without supplying any arguments, you will see a help message giving information on the supported arguments.

Here's an example of how you can run the CLI tool:
```sh
src/TemplateRefGenerator/bin/Debug/net10.0/TemplateRefGenerator --source-folder ../bicep-types-az/generated --output-folder ./generated
```

To get detailed logging, use the `--verbose` flag.

## Read-only resources

Read-only rendering is determined by the source resource type metadata. When
`ResourceType.WritableScopes` is `ScopeType.None`, the generated Bicep, ARM template,
and Terraform sections describe the resource as read-only, retain property reference
tables, and omit deployment syntax and usage examples. No provider-specific remarks
configuration is required. Incorrect writability metadata should be corrected
upstream in the API specifications or type generation.

## Versioning code samples

Reference pages are generated for every available API version of included providers.
To restrict a curated code sample to compatible API versions, set its optional
`ApiVersion` property in the provider's remarks configuration:

```json
"ApiVersion": {
  "Minimum": "2026-10-01-preview"
}
```

`Minimum` and `Maximum` are inclusive, optional bounds. A minimum-only requirement
includes that version and later versions, not just the latest version. Omit
`ApiVersion` to show the sample on all versions. These filters apply to Bicep,
ARM template, and Terraform samples without removing older reference pages.
