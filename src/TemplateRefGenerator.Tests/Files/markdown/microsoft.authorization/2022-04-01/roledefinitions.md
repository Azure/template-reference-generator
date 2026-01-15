---
title: Microsoft.Authorization/roleDefinitions 2022-04-01
description: Azure Microsoft.Authorization/roleDefinitions syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version 2022-04-01
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
# Microsoft.Authorization roleDefinitions 2022-04-01

> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest](../roledefinitions.md)
> - [2022-05-01-preview](../2022-05-01-preview/roledefinitions.md)
> - [2022-04-01](../2022-04-01/roledefinitions.md)
> - [2018-01-01-preview](../2018-01-01-preview/roledefinitions.md)
> - [2015-07-01](../2015-07-01/roledefinitions.md)

## Remarks

For guidance on creating role assignments and definitions, see [Create Azure RBAC resources by using Bicep](/azure/azure-resource-manager/bicep/scenarios-rbac).


::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The roleDefinitions resource type can be deployed with operations that target: 

* **Tenant** - See [tenant deployment commands](/azure/azure-resource-manager/bicep/deploy-to-tenant)* **Management groups** - See [management group deployment commands](/azure/azure-resource-manager/bicep/deploy-to-management-group)* **Subscription** - See [subscription deployment commands](/azure/azure-resource-manager/bicep/deploy-to-subscription)* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/bicep/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.authorization/change-log/roledefinitions.md).

## Resource format

To create a Microsoft.Authorization/roleDefinitions resource, add the following Bicep to your template.

```bicep
resource symbolicname 'Microsoft.Authorization/roleDefinitions@2022-04-01' = {
  scope: resourceSymbolicName or scope
  name: 'string'
  properties: {
    assignableScopes: [
      'string'
    ]
    description: 'string'
    permissions: [
      {
        actions: [
          'string'
        ]
        dataActions: [
          'string'
        ]
        notActions: [
          'string'
        ]
        notDataActions: [
          'string'
        ]
      }
    ]
    roleName: 'string'
    type: 'string'
  }
}
```
## Property Values
### Microsoft.Authorization/roleDefinitions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The resource name | string (required) |
| properties | Role definition properties. | [RoleDefinitionProperties](#roledefinitionproperties) |
| scope | Use when creating a resource at a scope that is different than the deployment scope. | Set this property to the symbolic name of a resource to apply the [extension resource](/azure/azure-resource-manager/bicep/scope-extension-resources). |

### Permission

| Name | Description | Value |
| ---- | ----------- | ------------ |
| actions | Allowed actions. | string[] |
| dataActions | Allowed Data actions. | string[] |
| notActions | Denied actions. | string[] |
| notDataActions | Denied Data actions. | string[] |

### RoleDefinitionProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| assignableScopes | Role definition assignable scopes. | string[] |
| description | The role definition description. | string |
| permissions | Role definition permissions. | [Permission](#permission)[] |
| roleName | The role name. | string |
| type | The role type. | string |

## Usage Examples
### Azure Quickstart Samples

The following [Azure Quickstart templates](https://aka.ms/azqst) contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |
> | [Azure Image Builder with Azure Windows Baseline](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/imagebuilder-windowsbaseline/main.bicep) | Creates an Azure Image Builder environment and builds a Windows Server image with the latest Windows Updates and Azure Windows Baseline applied. |
> | [Configure Dev Box service](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.devcenter/devbox-with-customized-image/main.bicep) | This template would create all Dev Box admin resources as per Dev Box quick start guide (/azure/dev-box/quickstart-create-dev-box). You can view all resources created, or directly go to DevPortal.microsoft.com to create your first Dev Box. |
> | [Create a new role def via a subscription level deployment](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-role-def/main.bicep) | This template is a subscription level template that will create a role definition at subscription scope. |


::: zone-end

::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The roleDefinitions resource type can be deployed with operations that target: 

* **Tenant** - See [tenant deployment commands](/azure/azure-resource-manager/templates/deploy-to-tenant)* **Management groups** - See [management group deployment commands](/azure/azure-resource-manager/templates/deploy-to-management-group)* **Subscription** - See [subscription deployment commands](/azure/azure-resource-manager/templates/deploy-to-subscription)* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/templates/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.authorization/change-log/roledefinitions.md).

## Resource format

To create a Microsoft.Authorization/roleDefinitions resource, add the following JSON to your template.

```json
{
  "type": "Microsoft.Authorization/roleDefinitions",
  "apiVersion": "2022-04-01",
  "name": "string",
  "properties": {
    "assignableScopes": [ "string" ],
    "description": "string",
    "permissions": [
      {
        "actions": [ "string" ],
        "dataActions": [ "string" ],
        "notActions": [ "string" ],
        "notDataActions": [ "string" ]
      }
    ],
    "roleName": "string",
    "type": "string"
  }
}
```
## Property Values
### Microsoft.Authorization/roleDefinitions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| apiVersion | The api version | '2022-04-01' |
| name | The resource name | string (required) |
| properties | Role definition properties. | [RoleDefinitionProperties](#roledefinitionproperties-1) |
| type | The resource type | 'Microsoft.Authorization/roleDefinitions' |

### Permission

| Name | Description | Value |
| ---- | ----------- | ------------ |
| actions | Allowed actions. | string[] |
| dataActions | Allowed Data actions. | string[] |
| notActions | Denied actions. | string[] |
| notDataActions | Denied Data actions. | string[] |

### RoleDefinitionProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| assignableScopes | Role definition assignable scopes. | string[] |
| description | The role definition description. | string |
| permissions | Role definition permissions. | [Permission](#permission-1)[] |
| roleName | The role name. | string |
| type | The role type. | string |

## Usage Examples
### Azure Quickstart Templates

The following [Azure Quickstart templates](https://aka.ms/azqst) deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |
> | [Azure Image Builder with Azure Windows Baseline](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/imagebuilder-windowsbaseline)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fdemos%2Fimagebuilder-windowsbaseline%2Fazuredeploy.json) | Creates an Azure Image Builder environment and builds a Windows Server image with the latest Windows Updates and Azure Windows Baseline applied. |
> | [Configure Dev Box service](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.devcenter/devbox-with-customized-image)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.devcenter%2Fdevbox-with-customized-image%2Fazuredeploy.json) | This template would create all Dev Box admin resources as per Dev Box quick start guide (/azure/dev-box/quickstart-create-dev-box). You can view all resources created, or directly go to DevPortal.microsoft.com to create your first Dev Box. |
> | [Create a new role def via a subscription level deployment](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-role-def)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsubscription-deployments%2Fcreate-role-def%2Fazuredeploy.json) | This template is a subscription level template that will create a role definition at subscription scope. |
> | [Deploy a Storage Account for SAP ILM Store](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/sap/sap-ilm-store)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Fsap%2Fsap-ilm-store%2Fazuredeploy.json) | The Microsoft Azure Storage Account can now be used as a ILM Store to persist the Archive files and attachments from an SAP ILM system. An ILM Store is a component which fulfills the requirements of SAP ILM compliant storage systems. One can store archive files in a storage media using WebDAV interface standards while making use of SAP ILM Retention Management rules. For more information about SAP ILM Store, refer to the &lt;a href='https://www.sap.com'&gt; SAP Help Portal &lt;/a&gt;. |
> | [Deploy Darktrace Autoscaling vSensors](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/darktrace/darktrace-vsensor-autoscaling)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Fdarktrace%2Fdarktrace-vsensor-autoscaling%2Fazuredeploy.json) | This template allows you to deploy an automatically autoscaling deployment of Darktrace vSensors |
> | [IBM Cloud Pak for Data on Azure](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/ibm-cloud-pak/ibm-cloud-pak-for-data)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Fibm-cloud-pak%2Fibm-cloud-pak-for-data%2Fazuredeploy.json) | This template deploys an Openshift cluster on Azure with all the required resources, infrastructure and then deploys IBM Cloud Pak for Data  along with the add-ons that user chooses. |


::: zone-end

::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The roleDefinitions resource type can be deployed with operations that target: 

* **Tenant*** **Management groups*** **Subscription*** **Resource groups**

For a list of changed properties in each API version, see [change log](~/microsoft.authorization/change-log/roledefinitions.md).

## Resource format

To create a Microsoft.Authorization/roleDefinitions resource, add the following Terraform to your template.

```terraform
resource "azapi_resource" "symbolicname" {
  type = "Microsoft.Authorization/roleDefinitions@2022-04-01"
  name = "string"
  parent_id = "string"
  body = {
    properties = {
      assignableScopes = [
        "string"
      ]
      description = "string"
      permissions = [
        {
          actions = [
            "string"
          ]
          dataActions = [
            "string"
          ]
          notActions = [
            "string"
          ]
          notDataActions = [
            "string"
          ]
        }
      ]
      roleName = "string"
      type = "string"
    }
  }
}
```
## Property Values
### Microsoft.Authorization/roleDefinitions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | The resource name | string (required) |
| parent_id | The ID of the resource to apply this extension resource to. | string (required) |
| properties | Role definition properties. | [RoleDefinitionProperties](#roledefinitionproperties-2) |
| type | The resource type | "Microsoft.Authorization/roleDefinitions@2022-04-01" |

### Permission

| Name | Description | Value |
| ---- | ----------- | ------------ |
| actions | Allowed actions. | string[] |
| dataActions | Allowed Data actions. | string[] |
| notActions | Denied actions. | string[] |
| notDataActions | Denied Data actions. | string[] |

### RoleDefinitionProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| assignableScopes | Role definition assignable scopes. | string[] |
| description | The role definition description. | string |
| permissions | Role definition permissions. | [Permission](#permission-2)[] |
| roleName | The role name. | string |
| type | The role type. | string |

## Usage Examples
### Terraform Samples

A basic example of deploying custom Role Definition.

```terraform
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
    azurerm = {
      source = "hashicorp/azurerm"
    }
  }
}

provider "azurerm" {
  features {
  }
}

provider "azapi" {
  skip_provider_registration = false
}

variable "resource_name" {
  type    = string
  default = "acctest0001"
}

variable "location" {
  type    = string
  default = "eastus"
}

data "azurerm_client_config" "current" {
}

data "azapi_resource" "subscription" {
  type                   = "Microsoft.Resources/subscriptions@2021-01-01"
  resource_id            = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  response_export_values = ["*"]
}

resource "azapi_resource" "roleDefinition" {
  type      = "Microsoft.Authorization/roleDefinitions@2018-01-01-preview"
  parent_id = data.azapi_resource.subscription.id
  name      = "6faae21a-0cd6-4536-8c23-a278823d12ed"
  body = {
    properties = {
      assignableScopes = [
        data.azapi_resource.subscription.id,
      ]
      description = ""
      permissions = [
        {
          actions = [
            "*",
          ]
          dataActions = [
          ]
          notActions = [
          ]
          notDataActions = [
          ]
        },
      ]
      roleName = var.resource_name
      type     = "CustomRole"
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}
```

::: zone-end
