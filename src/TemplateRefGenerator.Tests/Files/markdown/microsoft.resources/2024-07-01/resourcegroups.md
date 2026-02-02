---
title: Microsoft.Resources/resourceGroups 2024-07-01
description: Azure Microsoft.Resources/resourceGroups syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version 2024-07-01
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
# Microsoft.Resources resourceGroups 2024-07-01

> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest](../resourcegroups.md)
> - [2025-04-01](../2025-04-01/resourcegroups.md)
> - [2025-03-01](../2025-03-01/resourcegroups.md)
> - [2024-11-01](../2024-11-01/resourcegroups.md)
> - [2024-07-01](../2024-07-01/resourcegroups.md)
> - [2024-03-01](../2024-03-01/resourcegroups.md)
> - [2023-07-01](../2023-07-01/resourcegroups.md)
> - [2022-09-01](../2022-09-01/resourcegroups.md)
> - [2021-04-01](../2021-04-01/resourcegroups.md)
> - [2021-01-01](../2021-01-01/resourcegroups.md)
> - [2020-10-01](../2020-10-01/resourcegroups.md)
> - [2020-08-01](../2020-08-01/resourcegroups.md)
> - [2020-06-01](../2020-06-01/resourcegroups.md)
> - [2019-10-01](../2019-10-01/resourcegroups.md)
> - [2019-08-01](../2019-08-01/resourcegroups.md)
> - [2019-07-01](../2019-07-01/resourcegroups.md)
> - [2019-05-10](../2019-05-10/resourcegroups.md)
> - [2019-05-01](../2019-05-01/resourcegroups.md)
> - [2019-03-01](../2019-03-01/resourcegroups.md)
> - [2018-05-01](../2018-05-01/resourcegroups.md)
> - [2018-02-01](../2018-02-01/resourcegroups.md)
> - [2017-05-10](../2017-05-10/resourcegroups.md)
> - [2016-09-01](../2016-09-01/resourcegroups.md)
> - [2016-07-01](../2016-07-01/resourcegroups.md)
> - [2016-02-01](../2016-02-01/resourcegroups.md)
> - [2015-11-01](../2015-11-01/resourcegroups.md)


::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The resourceGroups resource type can be deployed with operations that target: 

* **Subscription** - See [subscription deployment commands](/azure/azure-resource-manager/bicep/deploy-to-subscription)

For a list of changed properties in each API version, see [change log](~/microsoft.resources/change-log/resourcegroups.md).

## Resource format

To create a Microsoft.Resources/resourceGroups resource, add the following Bicep to your template.

```bicep
resource symbolicname 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  location: 'string'
  managedBy: 'string'
  name: 'string'
  properties: {}
  tags: {
    {customized property}: 'string'
  }
}
```
## Property Values
### Microsoft.Resources/resourceGroups

| Name | Description | Value |
| ---- | ----------- | ------------ |
| location | The location of the resource group. It cannot be changed after the resource group has been created. It must be one of the supported Azure locations. | string (required) |
| managedBy | The ID of the resource that manages this resource group. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 1<br />Max length = 90<br />Pattern = `^[-\w\._\(\)]+$` (required) |
| properties | The resource group properties. | [ResourceGroupProperties](#resourcegroupproperties) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |

### ResourceGroupProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ResourceGroupTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

## Usage Examples
### Bicep Samples

A basic example of deploying a resource group.

```bicep
targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'myResourceGroup'
  location: deployment().location
  tags: {
    environment: 'production'
  }
}
```
A basic example of deploying Resource Group.

```bicep
targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Resource Group](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/resources/resource-group) | AVM Resource Module for Resource Group |

### Azure Quickstart Samples

The following [Azure Quickstart templates](https://aka.ms/azqst) contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |
> | [ Configure Deployment Environments service](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.devcenter/deployment-environments/main.bicep) | This template provides a way to configure Deployment Environments. |
> | [Create a new Datadog Organization](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.datadog/datadog/main.bicep) | This template creates a new Datadog - An Azure Native ISV Service resource and a Datadog organization to monitor resources in your subscription. |
> | [Create a resourceGroup](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-rg/main.bicep) | This template is a subscription level template that will create a resourceGroup.  Currently, this template can be deployed via the Azure Portal. |
> | [Create a resourceGroup, apply a lock and RBAC](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-rg-lock-role-assignment/main.bicep) | This template is a subscription level template that will create a resourceGroup, apply a lock the the resourceGroup and assign contributor permssions to the supplied principalId.  Currently, this template cannot be deployed via the Azure Portal. |
> | [Create a subscription, resourceGroup and storageAccount](https://github.com/Azure/azure-quickstart-templates/tree/master/managementgroup-deployments/create-subscription-resourcegroup/main.bicep) | This template is a management group template that will create a subscription, a resourceGroup and a storageAccount in the same template.  It can be used for an Enterprise Agreement billing mode only.  The official documentation shows modifications needed for other types of accounts. |
> | [Create an Azure Virtual Network Manager and sample VNETs](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/microsoft.network/virtual-network-manager-connectivity/main.bicep) | This template deploys an Azure Virtual Network Manager and sample virtual networks into the named resource group. It supports multiple connectivity topologies and network group membership types. |


::: zone-end

::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The resourceGroups resource type can be deployed with operations that target: 

* **Subscription** - See [subscription deployment commands](/azure/azure-resource-manager/templates/deploy-to-subscription)

For a list of changed properties in each API version, see [change log](~/microsoft.resources/change-log/resourcegroups.md).

## Resource format

To create a Microsoft.Resources/resourceGroups resource, add the following JSON to your template.

```json
{
  "type": "Microsoft.Resources/resourceGroups",
  "apiVersion": "2024-07-01",
  "name": "string",
  "location": "string",
  "managedBy": "string",
  "properties": {
  },
  "tags": {
    "{customized property}": "string"
  }
}
```
## Property Values
### Microsoft.Resources/resourceGroups

| Name | Description | Value |
| ---- | ----------- | ------------ |
| apiVersion | The api version | '2024-07-01' |
| location | The location of the resource group. It cannot be changed after the resource group has been created. It must be one of the supported Azure locations. | string (required) |
| managedBy | The ID of the resource that manages this resource group. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 1<br />Max length = 90<br />Pattern = `^[-\w\._\(\)]+$` (required) |
| properties | The resource group properties. | [ResourceGroupProperties](#resourcegroupproperties-1) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |
| type | The resource type | 'Microsoft.Resources/resourceGroups' |

### ResourceGroupProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ResourceGroupTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

## Usage Examples
### Azure Quickstart Templates

The following [Azure Quickstart templates](https://aka.ms/azqst) deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |
> | [ Configure Deployment Environments service](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.devcenter/deployment-environments)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.devcenter%2Fdeployment-environments%2Fazuredeploy.json) | This template provides a way to configure Deployment Environments. |
> | [Create a new Datadog Organization](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.datadog/datadog)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.datadog%2Fdatadog%2Fazuredeploy.json) | This template creates a new Datadog - An Azure Native ISV Service resource and a Datadog organization to monitor resources in your subscription. |
> | [Create a resourceGroup](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-rg)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsubscription-deployments%2Fcreate-rg%2Fazuredeploy.json) | This template is a subscription level template that will create a resourceGroup.  Currently, this template can be deployed via the Azure Portal. |
> | [Create a resourceGroup, apply a lock and RBAC](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/create-rg-lock-role-assignment)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsubscription-deployments%2Fcreate-rg-lock-role-assignment%2Fazuredeploy.json) | This template is a subscription level template that will create a resourceGroup, apply a lock the the resourceGroup and assign contributor permssions to the supplied principalId.  Currently, this template cannot be deployed via the Azure Portal. |
> | [Create a subscription, resourceGroup and storageAccount](https://github.com/Azure/azure-quickstart-templates/tree/master/managementgroup-deployments/create-subscription-resourcegroup)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fmanagementgroup-deployments%2Fcreate-subscription-resourcegroup%2Fazuredeploy.json) | This template is a management group template that will create a subscription, a resourceGroup and a storageAccount in the same template.  It can be used for an Enterprise Agreement billing mode only.  The official documentation shows modifications needed for other types of accounts. |
> | [Create an Azure Virtual Network Manager and sample VNETs](https://github.com/Azure/azure-quickstart-templates/tree/master/subscription-deployments/microsoft.network/virtual-network-manager-connectivity)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fsubscription-deployments%2Fmicrosoft.network%2Fvirtual-network-manager-connectivity%2Fazuredeploy.json) | This template deploys an Azure Virtual Network Manager and sample virtual networks into the named resource group. It supports multiple connectivity topologies and network group membership types. |


::: zone-end

::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The resourceGroups resource type can be deployed with operations that target: 

* **Subscription**

For a list of changed properties in each API version, see [change log](~/microsoft.resources/change-log/resourcegroups.md).

## Resource format

To create a Microsoft.Resources/resourceGroups resource, add the following Terraform to your template.

```terraform
resource "azapi_resource" "symbolicname" {
  type = "Microsoft.Resources/resourceGroups@2024-07-01"
  name = "string"
  parent_id = "string"
  location = "string"
  tags = {
    {customized property} = "string"
  }
  body = {
    managedBy = "string"
    properties = {
    }
  }
}
```
## Property Values
### Microsoft.Resources/resourceGroups

| Name | Description | Value |
| ---- | ----------- | ------------ |
| location | The location of the resource group. It cannot be changed after the resource group has been created. It must be one of the supported Azure locations. | string (required) |
| managedBy | The ID of the resource that manages this resource group. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 1<br />Max length = 90<br />Pattern = `^[-\w\._\(\)]+$` (required) |
| properties | The resource group properties. | [ResourceGroupProperties](#resourcegroupproperties-2) |
| tags | Resource tags | Dictionary of tag names and values. |
| type | The resource type | "Microsoft.Resources/resourceGroups@2024-07-01" |

### ResourceGroupProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ResourceGroupTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

## Usage Examples
### Terraform Samples

A basic example of deploying Resource Group.

```terraform
terraform {
  required_providers {
    azapi = {
      source = "Azure/azapi"
    }
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
  default = "westeurope"
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Resource Group](https://github.com/Azure/terraform-azurerm-avm-res-resources-resourcegroup) | AVM Resource Module for Resource Group |


::: zone-end
