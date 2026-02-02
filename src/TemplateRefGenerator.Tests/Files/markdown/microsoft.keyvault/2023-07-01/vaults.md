---
title: Microsoft.KeyVault/vaults 2023-07-01
description: Azure Microsoft.KeyVault/vaults syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version 2023-07-01
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
# Microsoft.KeyVault vaults 2023-07-01

> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest](../vaults.md)
> - [2025-05-01](../2025-05-01/vaults.md)
> - [2024-12-01-preview](../2024-12-01-preview/vaults.md)
> - [2024-11-01](../2024-11-01/vaults.md)
> - [2024-04-01-preview](../2024-04-01-preview/vaults.md)
> - [2023-07-01](../2023-07-01/vaults.md)
> - [2023-02-01](../2023-02-01/vaults.md)
> - [2022-11-01](../2022-11-01/vaults.md)
> - [2022-07-01](../2022-07-01/vaults.md)
> - [2022-02-01-preview](../2022-02-01-preview/vaults.md)
> - [2021-11-01-preview](../2021-11-01-preview/vaults.md)
> - [2021-10-01](../2021-10-01/vaults.md)
> - [2021-06-01-preview](../2021-06-01-preview/vaults.md)
> - [2021-04-01-preview](../2021-04-01-preview/vaults.md)
> - [2020-04-01-preview](../2020-04-01-preview/vaults.md)
> - [2019-09-01](../2019-09-01/vaults.md)
> - [2018-02-14](../2018-02-14/vaults.md)
> - [2018-02-14-preview](../2018-02-14-preview/vaults.md)
> - [2016-10-01](../2016-10-01/vaults.md)
> - [2015-06-01](../2015-06-01/vaults.md)

## Remarks

For guidance on using key vaults for secure values, see [Manage secrets by using Bicep](/azure/azure-resource-manager/bicep/scenarios-secrets).

For a quickstart on creating a secret, see [Quickstart: Set and retrieve a secret from Azure Key Vault using an ARM template](/azure/key-vault/secrets/quick-create-template).

For a quickstart on creating a key, see [Quickstart: Create an Azure key vault and a key by using ARM template](/azure/key-vault/keys/quick-create-template).


::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The vaults resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/bicep/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.keyvault/change-log/vaults.md).

## Resource format

To create a Microsoft.KeyVault/vaults resource, add the following Bicep to your template.

```bicep
resource symbolicname 'Microsoft.KeyVault/vaults@2023-07-01' = {
  location: 'string'
  name: 'string'
  properties: {
    accessPolicies: [
      {
        applicationId: 'string'
        objectId: 'string'
        permissions: {
          certificates: [
            'string'
          ]
          keys: [
            'string'
          ]
          secrets: [
            'string'
          ]
          storage: [
            'string'
          ]
        }
        tenantId: 'string'
      }
    ]
    createMode: 'string'
    enabledForDeployment: bool
    enabledForDiskEncryption: bool
    enabledForTemplateDeployment: bool
    enablePurgeProtection: bool
    enableRbacAuthorization: bool
    enableSoftDelete: bool
    networkAcls: {
      bypass: 'string'
      defaultAction: 'string'
      ipRules: [
        {
          value: 'string'
        }
      ]
      virtualNetworkRules: [
        {
          id: 'string'
          ignoreMissingVnetServiceEndpoint: bool
        }
      ]
    }
    provisioningState: 'string'
    publicNetworkAccess: 'string'
    sku: {
      family: 'string'
      name: 'string'
    }
    softDeleteRetentionInDays: int
    tenantId: 'string'
    vaultUri: 'string'
  }
  tags: {
    {customized property}: 'string'
  }
}
```
## Property Values
### Microsoft.KeyVault/vaults

| Name | Description | Value |
| ---- | ----------- | ------------ |
| location | The supported Azure location where the key vault should be created. | string (required) |
| name | The resource name | string <br /><br />Constraints:<br />Pattern = `^[a-zA-Z0-9-]{3,24}$` (required) |
| properties | Properties of the vault | [VaultProperties](#vaultproperties) (required) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |

### AccessPolicyEntry

| Name | Description | Value |
| ---- | ----------- | ------------ |
| applicationId | Application ID of the client making request on behalf of a principal | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` |
| objectId | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. | string (required) |
| permissions | Permissions the identity has for keys, secrets and certificates. | [Permissions](#permissions) (required) |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |

### IPRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| value | An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78). | string (required) |

### NetworkRuleSet

| Name | Description | Value |
| ---- | ----------- | ------------ |
| bypass | Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'. | 'AzureServices'<br />'None' |
| defaultAction | The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated. | 'Allow'<br />'Deny' |
| ipRules | The list of IP address rules. | [IPRule](#iprule)[] |
| virtualNetworkRules | The list of virtual network rules. | [VirtualNetworkRule](#virtualnetworkrule)[] |

### Permissions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| certificates | Permissions to certificates | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'delete'<br />'deleteissuers'<br />'get'<br />'getissuers'<br />'import'<br />'list'<br />'listissuers'<br />'managecontacts'<br />'manageissuers'<br />'purge'<br />'recover'<br />'restore'<br />'setissuers'<br />'update' |
| keys | Permissions to keys | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'decrypt'<br />'delete'<br />'encrypt'<br />'get'<br />'getrotationpolicy'<br />'import'<br />'list'<br />'purge'<br />'recover'<br />'release'<br />'restore'<br />'rotate'<br />'setrotationpolicy'<br />'sign'<br />'unwrapKey'<br />'update'<br />'verify'<br />'wrapKey' |
| secrets | Permissions to secrets | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'get'<br />'list'<br />'purge'<br />'recover'<br />'restore'<br />'set' |
| storage | Permissions to storage accounts | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'deletesas'<br />'get'<br />'getsas'<br />'list'<br />'listsas'<br />'purge'<br />'recover'<br />'regeneratekey'<br />'restore'<br />'set'<br />'setsas'<br />'update' |

### Sku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| family | SKU family name | 'A' (required) |
| name | SKU name to specify whether the key vault is a standard vault or a premium vault. | 'premium'<br />'standard' (required) |

### VaultCreateOrUpdateParametersTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VaultProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| accessPolicies | An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required. | [AccessPolicyEntry](#accesspolicyentry)[] |
| createMode | The vault's create mode to indicate whether the vault need to be recovered or not. | 'default'<br />'recover' |
| enabledForDeployment | Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | bool |
| enabledForDiskEncryption | Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | bool |
| enabledForTemplateDeployment | Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | bool |
| enablePurgeProtection | Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value. | bool |
| enableRbacAuthorization | Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC. | bool |
| enableSoftDelete | Property to specify whether the 'soft delete' functionality is enabled for this key vault. If it's not set to any value(true or false) when creating new key vault, it will be set to true by default. Once set to true, it cannot be reverted to false. | bool |
| networkAcls | Rules governing the accessibility of the key vault from specific network locations. | [NetworkRuleSet](#networkruleset) |
| provisioningState | Provisioning state of the vault. | 'RegisteringDns'<br />'Succeeded' |
| publicNetworkAccess | Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules. | string |
| sku | SKU details | [Sku](#sku) (required) |
| softDeleteRetentionInDays | softDelete data retention days. It accepts &gt;=7 and &lt;=90. | int |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |
| vaultUri | The URI of the vault for performing operations on keys and secrets. | string |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'. | string (required) |
| ignoreMissingVnetServiceEndpoint | Property to specify whether NRP will ignore the check if parent subnet has serviceEndpoints configured. | bool |

## Usage Examples
### Bicep Samples

A basic example of deploying Key Vault.

```bicep
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: [
      {
        objectId: deployer().objectId
        permissions: {
          certificates: [
            'ManageContacts'
          ]
          keys: [
            'Create'
          ]
          secrets: [
            'Set'
          ]
          storage: []
        }
        tenantId: deployer().tenantId
      }
    ]
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: deployer().tenantId
  }
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Key Vault](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/key-vault/vault) | AVM Resource Module for Key Vault |

### Azure Quickstart Samples

The following [Azure Quickstart templates](https://aka.ms/azqst) contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |
> | [AKS Cluster with a NAT Gateway and an Application Gateway](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/aks-nat-agic/main.bicep) | This sample shows how to a deploy an AKS cluster with NAT Gateway for outbound connections and an Application Gateway for inbound connections. |
> | [AKS cluster with the Application Gateway Ingress Controller](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/aks-application-gateway-ingress-controller/main.bicep) | This sample shows how to deploy an AKS cluster with Application Gateway, Application Gateway Ingress Controller, Azure Container Registry, Log Analytics and Key Vault |
> | [Application Gateway with internal API Management and Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/private-webapp-with-app-gateway-and-apim/main.bicep) | Application Gateway routing Internet traffic to a virtual network (internal mode) API Management instance which services a web API hosted in an Azure Web App. |
> | [Azure AI Foundry basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-basics/main.bicep) | This set of templates demonstrates how to set up Azure AI Foundry with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-cmk/main.bicep) | This set of templates demonstrates how to set up Azure AI Foundry with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry Network Restricted](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-network-restricted/main.bicep) | This set of templates demonstrates how to set up Azure AI Foundry with private link and egress disabled, using Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry with Microsoft Entra ID Authentication](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-entraid-passthrough/main.bicep) | This set of templates demonstrates how to set up Azure AI Foundry with Microsoft Entra ID authentication for dependent resources, such as Azure AI Services and Azure Storage. |
> | [Azure AI Studio basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aistudio-cmk-service-side-encryption/main.bicep) | This set of templates demonstrates how to set up Azure AI Studio with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Studio Network Restricted](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-network-restricted/main.bicep) | This set of templates demonstrates how to set up Azure AI Studio with private link and egress disabled, using Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure Function app and an HTTP-triggered function](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/function-http-trigger/main.bicep) | This example deploys an Azure Function app and an HTTP-triggered function inline in the template. It also deploys a Key Vault and populates a secret with the function app's host key. |
> | [Azure Machine Learning end-to-end secure setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-end-to-end-secure/main.bicep) | This set of Bicep templates demonstrates how to set up Azure Machine Learning end-to-end in a secure set up. This reference implementation includes the Workspace, a compute cluster, compute instance and attached private AKS cluster. |
> | [Azure Machine Learning end-to-end secure setup (legacy)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-end-to-end-secure-v1-legacy-mode/main.bicep) | This set of Bicep templates demonstrates how to set up Azure Machine Learning end-to-end in a secure set up. This reference implementation includes the Workspace, a compute cluster, compute instance and attached private AKS cluster. |
> | [Azure Storage Account Encryption with customer-managed key](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.storage/storage-blob-encryption-with-cmk/main.bicep) | This template deploys a Storage Account with a customer-managed key for encryption that's generated and placed inside a Key Vault. |
> | [Basic Agent Setup Identity](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/basic-agent-identity/main.bicep) | This set of templates demonstrates how to set up Azure AI Agent Service with the basic setup using managed identity authetication for the AI Service/AOAI connection. Agents use multi-tenant search and storage resources fully managed by Microsoft. You won’t have visibility or control over these underlying Azure resources. |
> | [Create a Key Vault and a list of secrets](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-secret-create/main.bicep) | This template creates a Key Vault and a list of secrets within the key vault as passed along with the parameters |
> | [Create a network security perimeter](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/network-security-perimeter-create/main.bicep) | This template creates a network security perimeter and it's associated resource for protecting an Azure key vault. |
> | [Create an AKS compute target with a Private IP address](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-private-ip/main.bicep) | This template creates an AKS compute target in given Azure Machine Learning service workspace with a private IP address. |
> | [Create an API Management service with SSL from KeyVault](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.apimanagement/api-management-key-vault-create/main.bicep) | This template deploys an API Management service configured with User Assigned Identity. It uses this identity to fetch SSL certificate from KeyVault and keeps it updated by checking every 4 hours. |
> | [Create an Azure Key Vault and a secret](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-create/main.bicep) | This template creates an Azure Key Vault and a secret. |
> | [Create an Azure Key Vault with RBAC and a secret](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-create-rbac/main.bicep) | This template creates an Azure Key Vault and a secret. Instead of relying on access policies, it leverages Azure RBAC to manage authorization on secrets |
> | [Create an Azure Machine Learning service workspace](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace/main.bicep) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the minimal set of resources you require to get started with Azure Machine Learning. |
> | [Create an Azure Machine Learning service workspace (CMK)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-cmk-service-side-encryption/main.bicep) | This deployment template specifies how to create an Azure Machine Learning workspace with service-side encryption using your encryption keys. |
> | [Create an Azure Machine Learning service workspace (CMK)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-cmk/main.bicep) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. The example shows how to configure Azure Machine Learning for encryption with a customer-managed encryption key. |
> | [Create an Azure Machine Learning service workspace (legacy)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-vnet-v1-legacy-mode/main.bicep) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the set of resources you require to get started with Azure Machine Learning in a network isolated set up. |
> | [Create an Azure Machine Learning service workspace (vnet)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-vnet/main.bicep) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the set of resources you require to get started with Azure Machine Learning in a network isolated set up. |
> | [Create Application Gateway with Certificates](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.resources/deployment-script-azcli-agw-certificates/main.bicep) | This template shows how to generate Key Vault self-signed certificates, then reference from Application Gateway. |
> | [Create Key Vault with logging enabled](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-with-logging-create/main.bicep) | This template creates an Azure Key Vault and an Azure Storage account that is used for logging. It optionally creates resource locks to protect your Key Vault and storage resources. |
> | [Create key vault, managed identity, and role assignment](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-managed-identity-role-assignment/main.bicep) | This template creates a key vault, managed identity, and role assignment. |
> | [Creates a Cross-tenant Private Endpoint resource](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/private-endpoint/main.bicep) | This template allows you to create Priavate Endpoint resource within the same or cross-tenant environment and add dns zone configuration. |
> | [Creates a Dapr pub-sub servicebus app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-pubsub-servicebus/main.bicep) | Create a Dapr pub-sub servicebus app using Container Apps. |
> | [Deploy Secure AI Foundry with a managed virtual network](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-networking-aoao/main.bicep) | This template creates a secure Azure AI Foundry environment with robust network and identity security restrictions. |
> | [Deploy the Sports Analytics on Azure Architecture](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/sports-analytics-architecture/main.bicep) | Creates an Azure storage account with ADLS Gen 2 enabled, an Azure Data Factory instance with linked services for the storage account (an the Azure SQL Database if deployed), and an Azure Databricks instance. The AAD identity for the user deploying the template and the managed identity for the ADF instance will be granted the Storage Blob Data Contributor role on the storage account. There are also options to deploy an Azure Key Vault instance, an Azure SQL Database, and an Azure Event Hub (for streaming use cases). When an Azure Key Vault is deployed, the data factory managed identity and the AAD identity for the user deploying the template will be granted the Key Vault Secrets User role. |
> | [FinOps hub](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.costmanagement/finops-hub/main.bicep) | This template creates a new FinOps hub instance, including Data Explorer, Data Lake storage, and Data Factory. |
> | [Network Secured Agent with User Managed Identity](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/network-secured-agent/main.bicep) | This set of templates demonstrates how to set up Azure AI Agent Service with virtual network isolation using User Managed Identity authetication for the AI Service/AOAI connection and private network links to connect the agent to your secure data. |
> | [Standard Agent Setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/standard-agent/main.bicep) | This set of templates demonstrates how to set up Azure AI Agent Service with the standard setup, meaning with managed identity authentication for project/hub connections and public internet access enabled. Agents use customer-owned, single-tenant search and storage resources. With this setup, you have full control and visibility over these resources, but you will incur costs based on your usage. |
> | [Testing environment for Azure Firewall Premium](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/azurefirewall-premium/main.bicep) | This template creates an Azure Firewall Premium and Firewall Policy with premium features such as Intrusion Inspection Detection (IDPS), TLS inspection and Web Category filtering |


::: zone-end

::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The vaults resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/templates/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.keyvault/change-log/vaults.md).

## Resource format

To create a Microsoft.KeyVault/vaults resource, add the following JSON to your template.

```json
{
  "type": "Microsoft.KeyVault/vaults",
  "apiVersion": "2023-07-01",
  "name": "string",
  "location": "string",
  "properties": {
    "accessPolicies": [
      {
        "applicationId": "string",
        "objectId": "string",
        "permissions": {
          "certificates": [ "string" ],
          "keys": [ "string" ],
          "secrets": [ "string" ],
          "storage": [ "string" ]
        },
        "tenantId": "string"
      }
    ],
    "createMode": "string",
    "enabledForDeployment": "bool",
    "enabledForDiskEncryption": "bool",
    "enabledForTemplateDeployment": "bool",
    "enablePurgeProtection": "bool",
    "enableRbacAuthorization": "bool",
    "enableSoftDelete": "bool",
    "networkAcls": {
      "bypass": "string",
      "defaultAction": "string",
      "ipRules": [
        {
          "value": "string"
        }
      ],
      "virtualNetworkRules": [
        {
          "id": "string",
          "ignoreMissingVnetServiceEndpoint": "bool"
        }
      ]
    },
    "provisioningState": "string",
    "publicNetworkAccess": "string",
    "sku": {
      "family": "string",
      "name": "string"
    },
    "softDeleteRetentionInDays": "int",
    "tenantId": "string",
    "vaultUri": "string"
  },
  "tags": {
    "{customized property}": "string"
  }
}
```
## Property Values
### Microsoft.KeyVault/vaults

| Name | Description | Value |
| ---- | ----------- | ------------ |
| apiVersion | The api version | '2023-07-01' |
| location | The supported Azure location where the key vault should be created. | string (required) |
| name | The resource name | string <br /><br />Constraints:<br />Pattern = `^[a-zA-Z0-9-]{3,24}$` (required) |
| properties | Properties of the vault | [VaultProperties](#vaultproperties-1) (required) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |
| type | The resource type | 'Microsoft.KeyVault/vaults' |

### AccessPolicyEntry

| Name | Description | Value |
| ---- | ----------- | ------------ |
| applicationId | Application ID of the client making request on behalf of a principal | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` |
| objectId | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. | string (required) |
| permissions | Permissions the identity has for keys, secrets and certificates. | [Permissions](#permissions-1) (required) |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |

### IPRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| value | An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78). | string (required) |

### NetworkRuleSet

| Name | Description | Value |
| ---- | ----------- | ------------ |
| bypass | Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'. | 'AzureServices'<br />'None' |
| defaultAction | The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated. | 'Allow'<br />'Deny' |
| ipRules | The list of IP address rules. | [IPRule](#iprule-1)[] |
| virtualNetworkRules | The list of virtual network rules. | [VirtualNetworkRule](#virtualnetworkrule-1)[] |

### Permissions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| certificates | Permissions to certificates | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'delete'<br />'deleteissuers'<br />'get'<br />'getissuers'<br />'import'<br />'list'<br />'listissuers'<br />'managecontacts'<br />'manageissuers'<br />'purge'<br />'recover'<br />'restore'<br />'setissuers'<br />'update' |
| keys | Permissions to keys | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'decrypt'<br />'delete'<br />'encrypt'<br />'get'<br />'getrotationpolicy'<br />'import'<br />'list'<br />'purge'<br />'recover'<br />'release'<br />'restore'<br />'rotate'<br />'setrotationpolicy'<br />'sign'<br />'unwrapKey'<br />'update'<br />'verify'<br />'wrapKey' |
| secrets | Permissions to secrets | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'get'<br />'list'<br />'purge'<br />'recover'<br />'restore'<br />'set' |
| storage | Permissions to storage accounts | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'deletesas'<br />'get'<br />'getsas'<br />'list'<br />'listsas'<br />'purge'<br />'recover'<br />'regeneratekey'<br />'restore'<br />'set'<br />'setsas'<br />'update' |

### Sku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| family | SKU family name | 'A' (required) |
| name | SKU name to specify whether the key vault is a standard vault or a premium vault. | 'premium'<br />'standard' (required) |

### VaultCreateOrUpdateParametersTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VaultProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| accessPolicies | An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required. | [AccessPolicyEntry](#accesspolicyentry-1)[] |
| createMode | The vault's create mode to indicate whether the vault need to be recovered or not. | 'default'<br />'recover' |
| enabledForDeployment | Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | bool |
| enabledForDiskEncryption | Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | bool |
| enabledForTemplateDeployment | Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | bool |
| enablePurgeProtection | Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value. | bool |
| enableRbacAuthorization | Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC. | bool |
| enableSoftDelete | Property to specify whether the 'soft delete' functionality is enabled for this key vault. If it's not set to any value(true or false) when creating new key vault, it will be set to true by default. Once set to true, it cannot be reverted to false. | bool |
| networkAcls | Rules governing the accessibility of the key vault from specific network locations. | [NetworkRuleSet](#networkruleset-1) |
| provisioningState | Provisioning state of the vault. | 'RegisteringDns'<br />'Succeeded' |
| publicNetworkAccess | Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules. | string |
| sku | SKU details | [Sku](#sku-1) (required) |
| softDeleteRetentionInDays | softDelete data retention days. It accepts &gt;=7 and &lt;=90. | int |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |
| vaultUri | The URI of the vault for performing operations on keys and secrets. | string |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'. | string (required) |
| ignoreMissingVnetServiceEndpoint | Property to specify whether NRP will ignore the check if parent subnet has serviceEndpoints configured. | bool |

## Usage Examples
### Azure Quickstart Templates

The following [Azure Quickstart templates](https://aka.ms/azqst) deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |
> | [AKS Cluster with a NAT Gateway and an Application Gateway](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/aks-nat-agic)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fdemos%2Faks-nat-agic%2Fazuredeploy.json) | This sample shows how to a deploy an AKS cluster with NAT Gateway for outbound connections and an Application Gateway for inbound connections. |
> | [AKS cluster with the Application Gateway Ingress Controller](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/aks-application-gateway-ingress-controller)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.network%2Faks-application-gateway-ingress-controller%2Fazuredeploy.json) | This sample shows how to deploy an AKS cluster with Application Gateway, Application Gateway Ingress Controller, Azure Container Registry, Log Analytics and Key Vault |
> | [App Service Environment with Azure SQL backend](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/asev2-appservice-sql-vpngw)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.web%2Fasev2-appservice-sql-vpngw%2Fazuredeploy.json) | This template creates an App Service Environment with an Azure SQL backend along with private endpoints along with associated resources typically used in an private/isolated environment. |
> | [Application Gateway with internal API Management and Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/private-webapp-with-app-gateway-and-apim)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.web%2Fprivate-webapp-with-app-gateway-and-apim%2Fazuredeploy.json) | Application Gateway routing Internet traffic to a virtual network (internal mode) API Management instance which services a web API hosted in an Azure Web App. |
> | [Azure AI Foundry basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-basics)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faifoundry-basics%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Foundry with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-cmk)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faifoundry-cmk%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Foundry with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry Network Restricted](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-network-restricted)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faifoundry-network-restricted%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Foundry with private link and egress disabled, using Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Foundry with Microsoft Entra ID Authentication](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-entraid-passthrough)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faifoundry-entraid-passthrough%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Foundry with Microsoft Entra ID authentication for dependent resources, such as Azure AI Services and Azure Storage. |
> | [Azure AI Studio basic setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aistudio-cmk-service-side-encryption)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faistudio-cmk-service-side-encryption%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Studio with the basic setup, meaning with public internet access enabled, Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure AI Studio Network Restricted](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-network-restricted)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-network-restricted%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Studio with private link and egress disabled, using Microsoft-managed keys for encryption and Microsoft-managed identity configuration for the AI resource. |
> | [Azure Function app and an HTTP-triggered function](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/function-http-trigger)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.web%2Ffunction-http-trigger%2Fazuredeploy.json) | This example deploys an Azure Function app and an HTTP-triggered function inline in the template. It also deploys a Key Vault and populates a secret with the function app's host key. |
> | [Azure Machine Learning end-to-end secure setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-end-to-end-secure)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-end-to-end-secure%2Fazuredeploy.json) | This set of Bicep templates demonstrates how to set up Azure Machine Learning end-to-end in a secure set up. This reference implementation includes the Workspace, a compute cluster, compute instance and attached private AKS cluster. |
> | [Azure Machine Learning end-to-end secure setup (legacy)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-end-to-end-secure-v1-legacy-mode)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-end-to-end-secure-v1-legacy-mode%2Fazuredeploy.json) | This set of Bicep templates demonstrates how to set up Azure Machine Learning end-to-end in a secure set up. This reference implementation includes the Workspace, a compute cluster, compute instance and attached private AKS cluster. |
> | [Azure Machine Learning Workspace](https://github.com/Azure/azure-quickstart-templates/tree/master/modules/machine-learning-workspace/0.9)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fmodules%2Fmachine-learning-workspace%2F0.9%2Fazuredeploy.json) | This template creates a new Azure Machine Learning Workspace, along with an encrypted Storage Account, KeyVault and Applications Insights Logging |
> | [Azure Storage Account Encryption with customer-managed key](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.storage/storage-blob-encryption-with-cmk)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.storage%2Fstorage-blob-encryption-with-cmk%2Fazuredeploy.json) | This template deploys a Storage Account with a customer-managed key for encryption that's generated and placed inside a Key Vault. |
> | [Basic Agent Setup Identity](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/basic-agent-identity)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.azure-ai-agent-service%2Fbasic-agent-identity%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Agent Service with the basic setup using managed identity authetication for the AI Service/AOAI connection. Agents use multi-tenant search and storage resources fully managed by Microsoft. You won’t have visibility or control over these underlying Azure resources. |
> | [Connect to a Key Vault via private endpoint](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-private-endpoint)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-private-endpoint%2Fazuredeploy.json) | This sample shows how to use configure a virtual network and private DNS zone to access Key Vault via private endpoint. |
> | [Create a Key Vault and a list of secrets](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-secret-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-secret-create%2Fazuredeploy.json) | This template creates a Key Vault and a list of secrets within the key vault as passed along with the parameters |
> | [Create a KeyVault](https://github.com/Azure/azure-quickstart-templates/tree/master/modules/Microsoft.KeyVault/vaults/1.0)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fmodules%2FMicrosoft.KeyVault%2Fvaults%2F1.0%2Fazuredeploy.json) | This module creates a KeyVault resource with apiVersion 2019-09-01. |
> | [Create a network security perimeter](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/network-security-perimeter-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.network%2Fnetwork-security-perimeter-create%2Fazuredeploy.json) | This template creates a network security perimeter and it's associated resource for protecting an Azure key vault. |
> | [Create a new encrypted windows vm from gallery image](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/encrypt-create-new-vm-gallery-image)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fencrypt-create-new-vm-gallery-image%2Fazuredeploy.json) | This template creates a new encrypted windows vm using the server 2k12 gallery image. |
> | [Create a Private AKS Cluster with a Public DNS Zone](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/private-aks-cluster-with-public-dns-zone)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fdemos%2Fprivate-aks-cluster-with-public-dns-zone%2Fazuredeploy.json) | This sample shows how to a deploy a private AKS cluster with a Public DNS Zone. |
> | [Create AML workspace with multiple Datasets & Datastores](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-dataset-create-workspace-multiple-dataset-datastore)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-dataset-create-workspace-multiple-dataset-datastore%2Fazuredeploy.json) | This template creates Azure Machine Learning workspace with multiple datasets & datastores. |
> | [Create an AKS compute target with a Private IP address](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-private-ip)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-private-ip%2Fazuredeploy.json) | This template creates an AKS compute target in given Azure Machine Learning service workspace with a private IP address. |
> | [Create an API Management service with SSL from KeyVault](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.apimanagement/api-management-key-vault-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.apimanagement%2Fapi-management-key-vault-create%2Fazuredeploy.json) | This template deploys an API Management service configured with User Assigned Identity. It uses this identity to fetch SSL certificate from KeyVault and keeps it updated by checking every 4 hours. |
> | [Create an Application Gateway V2 with Key Vault](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/application-gateway-key-vault-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.network%2Fapplication-gateway-key-vault-create%2Fazuredeploy.json) | This template deploys an Application Gateway V2 in a Virtual Network, a user defined identity, Key Vault, a secret (cert data), and access policy on Key Vault and Application Gateway. |
> | [Create an Azure Key Vault and a secret](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-create%2Fazuredeploy.json) | This template creates an Azure Key Vault and a secret. |
> | [Create an Azure Key Vault with RBAC and a secret](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-create-rbac)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-create-rbac%2Fazuredeploy.json) | This template creates an Azure Key Vault and a secret. Instead of relying on access policies, it leverages Azure RBAC to manage authorization on secrets |
> | [Create an Azure Machine Learning service workspace](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-workspace%2Fazuredeploy.json) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the minimal set of resources you require to get started with Azure Machine Learning. |
> | [Create an Azure Machine Learning service workspace (CMK)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-cmk-service-side-encryption)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-workspace-cmk-service-side-encryption%2Fazuredeploy.json) | This deployment template specifies how to create an Azure Machine Learning workspace with service-side encryption using your encryption keys. |
> | [Create an Azure Machine Learning service workspace (CMK)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-cmk)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-workspace-cmk%2Fazuredeploy.json) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. The example shows how to configure Azure Machine Learning for encryption with a customer-managed encryption key. |
> | [Create an Azure Machine Learning service workspace (legacy)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-vnet-v1-legacy-mode)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-workspace-vnet-v1-legacy-mode%2Fazuredeploy.json) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the set of resources you require to get started with Azure Machine Learning in a network isolated set up. |
> | [Create an Azure Machine Learning service workspace (vnet)](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/machine-learning-workspace-vnet)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Fmachine-learning-workspace-vnet%2Fazuredeploy.json) | This deployment template specifies an Azure Machine Learning workspace, and its associated resources including Azure Key Vault, Azure Storage, Azure Application Insights and Azure Container Registry. This configuration describes the set of resources you require to get started with Azure Machine Learning in a network isolated set up. |
> | [Create and encrypt a new Windows VMSS with jumpbox](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/encrypt-vmss-windows-jumpbox)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fencrypt-vmss-windows-jumpbox%2Fazuredeploy.json) | This template allows you to deploy a simple VM Scale Set of Windows VMs using the lastest patched version of serveral Windows versions. This template also deploys a jumpbox with a public IP address in the same virtual network. You can connect to the jumpbox via this public IP address, then connect from there to VMs in the scale set via private IP addresses.This template enables encryption on the VM Scale Set of Windows VMs. |
> | [Create Application Gateway with Certificates](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.resources/deployment-script-azcli-agw-certificates)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.resources%2Fdeployment-script-azcli-agw-certificates%2Fazuredeploy.json) | This template shows how to generate Key Vault self-signed certificates, then reference from Application Gateway. |
> | [Create Key Vault with logging enabled](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-with-logging-create)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-with-logging-create%2Fazuredeploy.json) | This template creates an Azure Key Vault and an Azure Storage account that is used for logging. It optionally creates resource locks to protect your Key Vault and storage resources. |
> | [Create key vault, managed identity, and role assignment](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.keyvault/key-vault-managed-identity-role-assignment)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.keyvault%2Fkey-vault-managed-identity-role-assignment%2Fazuredeploy.json) | This template creates a key vault, managed identity, and role assignment. |
> | [Create new encrypted managed disks win-vm from gallery image](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/encrypt-create-new-vm-gallery-image-managed-disks)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fencrypt-create-new-vm-gallery-image-managed-disks%2Fazuredeploy.json) | This template creates a new encrypted managed disks windows vm using the server 2k12 gallery image. |
> | [Creates a Cross-tenant Private Endpoint resource](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/private-endpoint)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.network%2Fprivate-endpoint%2Fazuredeploy.json) | This template allows you to create Priavate Endpoint resource within the same or cross-tenant environment and add dns zone configuration. |
> | [Creates a Dapr pub-sub servicebus app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-pubsub-servicebus)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.app%2Fcontainer-app-dapr-pubsub-servicebus%2Fazuredeploy.json) | Create a Dapr pub-sub servicebus app using Container Apps. |
> | [Deploy Secure AI Foundry with a managed virtual network](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.machinelearningservices/aifoundry-networking-aoao)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.machinelearningservices%2Faifoundry-networking-aoao%2Fazuredeploy.json) | This template creates a secure Azure AI Foundry environment with robust network and identity security restrictions. |
> | [Deploy the Sports Analytics on Azure Architecture](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/sports-analytics-architecture)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fdemos%2Fsports-analytics-architecture%2Fazuredeploy.json) | Creates an Azure storage account with ADLS Gen 2 enabled, an Azure Data Factory instance with linked services for the storage account (an the Azure SQL Database if deployed), and an Azure Databricks instance. The AAD identity for the user deploying the template and the managed identity for the ADF instance will be granted the Storage Blob Data Contributor role on the storage account. There are also options to deploy an Azure Key Vault instance, an Azure SQL Database, and an Azure Event Hub (for streaming use cases). When an Azure Key Vault is deployed, the data factory managed identity and the AAD identity for the user deploying the template will be granted the Key Vault Secrets User role. |
> | [Enable encryption on a running Windows VM](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/encrypt-running-windows-vm)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fencrypt-running-windows-vm%2Fazuredeploy.json) | This template enables encryption on a running windows vm. |
> | [FinOps hub](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.costmanagement/finops-hub)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.costmanagement%2Ffinops-hub%2Fazuredeploy.json) | This template creates a new FinOps hub instance, including Data Explorer, Data Lake storage, and Data Factory. |
> | [Network Secured Agent with User Managed Identity](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/network-secured-agent)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.azure-ai-agent-service%2Fnetwork-secured-agent%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Agent Service with virtual network isolation using User Managed Identity authetication for the AI Service/AOAI connection and private network links to connect the agent to your secure data. |
> | [Standard Agent Setup](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.azure-ai-agent-service/standard-agent)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.azure-ai-agent-service%2Fstandard-agent%2Fazuredeploy.json) | This set of templates demonstrates how to set up Azure AI Agent Service with the standard setup, meaning with managed identity authentication for project/hub connections and public internet access enabled. Agents use customer-owned, single-tenant search and storage resources. With this setup, you have full control and visibility over these resources, but you will incur costs based on your usage. |
> | [Testing environment for Azure Firewall Premium](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.network/azurefirewall-premium)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.network%2Fazurefirewall-premium%2Fazuredeploy.json) | This template creates an Azure Firewall Premium and Firewall Policy with premium features such as Intrusion Inspection Detection (IDPS), TLS inspection and Web Category filtering |
> | [This template encrypts a running Windows VMSS](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.compute/encrypt-running-vmss-windows)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.compute%2Fencrypt-running-vmss-windows%2Fazuredeploy.json) | This template enables encryption on a running Windows VM Scale Set |


::: zone-end

::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The vaults resource type can be deployed with operations that target: 

* **Resource groups**

For a list of changed properties in each API version, see [change log](~/microsoft.keyvault/change-log/vaults.md).

## Resource format

To create a Microsoft.KeyVault/vaults resource, add the following Terraform to your template.

```terraform
resource "azapi_resource" "symbolicname" {
  type = "Microsoft.KeyVault/vaults@2023-07-01"
  name = "string"
  parent_id = "string"
  location = "string"
  tags = {
    {customized property} = "string"
  }
  body = {
    properties = {
      accessPolicies = [
        {
          applicationId = "string"
          objectId = "string"
          permissions = {
            certificates = [
              "string"
            ]
            keys = [
              "string"
            ]
            secrets = [
              "string"
            ]
            storage = [
              "string"
            ]
          }
          tenantId = "string"
        }
      ]
      createMode = "string"
      enabledForDeployment = bool
      enabledForDiskEncryption = bool
      enabledForTemplateDeployment = bool
      enablePurgeProtection = bool
      enableRbacAuthorization = bool
      enableSoftDelete = bool
      networkAcls = {
        bypass = "string"
        defaultAction = "string"
        ipRules = [
          {
            value = "string"
          }
        ]
        virtualNetworkRules = [
          {
            id = "string"
            ignoreMissingVnetServiceEndpoint = bool
          }
        ]
      }
      provisioningState = "string"
      publicNetworkAccess = "string"
      sku = {
        family = "string"
        name = "string"
      }
      softDeleteRetentionInDays = int
      tenantId = "string"
      vaultUri = "string"
    }
  }
}
```
## Property Values
### Microsoft.KeyVault/vaults

| Name | Description | Value |
| ---- | ----------- | ------------ |
| location | The supported Azure location where the key vault should be created. | string (required) |
| name | The resource name | string <br /><br />Constraints:<br />Pattern = `^[a-zA-Z0-9-]{3,24}$` (required) |
| properties | Properties of the vault | [VaultProperties](#vaultproperties-2) (required) |
| tags | Resource tags | Dictionary of tag names and values. |
| type | The resource type | "Microsoft.KeyVault/vaults@2023-07-01" |

### AccessPolicyEntry

| Name | Description | Value |
| ---- | ----------- | ------------ |
| applicationId | Application ID of the client making request on behalf of a principal | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` |
| objectId | The object ID of a user, service principal or security group in the Azure Active Directory tenant for the vault. The object ID must be unique for the list of access policies. | string (required) |
| permissions | Permissions the identity has for keys, secrets and certificates. | [Permissions](#permissions-2) (required) |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |

### IPRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| value | An IPv4 address range in CIDR notation, such as '124.56.78.91' (simple IP address) or '124.56.78.0/24' (all addresses that start with 124.56.78). | string (required) |

### NetworkRuleSet

| Name | Description | Value |
| ---- | ----------- | ------------ |
| bypass | Tells what traffic can bypass network rules. This can be 'AzureServices' or 'None'.  If not specified the default is 'AzureServices'. | 'AzureServices'<br />'None' |
| defaultAction | The default action when no rule from ipRules and from virtualNetworkRules match. This is only used after the bypass property has been evaluated. | 'Allow'<br />'Deny' |
| ipRules | The list of IP address rules. | [IPRule](#iprule-2)[] |
| virtualNetworkRules | The list of virtual network rules. | [VirtualNetworkRule](#virtualnetworkrule-2)[] |

### Permissions

| Name | Description | Value |
| ---- | ----------- | ------------ |
| certificates | Permissions to certificates | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'delete'<br />'deleteissuers'<br />'get'<br />'getissuers'<br />'import'<br />'list'<br />'listissuers'<br />'managecontacts'<br />'manageissuers'<br />'purge'<br />'recover'<br />'restore'<br />'setissuers'<br />'update' |
| keys | Permissions to keys | String array containing any of:<br />'all'<br />'backup'<br />'create'<br />'decrypt'<br />'delete'<br />'encrypt'<br />'get'<br />'getrotationpolicy'<br />'import'<br />'list'<br />'purge'<br />'recover'<br />'release'<br />'restore'<br />'rotate'<br />'setrotationpolicy'<br />'sign'<br />'unwrapKey'<br />'update'<br />'verify'<br />'wrapKey' |
| secrets | Permissions to secrets | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'get'<br />'list'<br />'purge'<br />'recover'<br />'restore'<br />'set' |
| storage | Permissions to storage accounts | String array containing any of:<br />'all'<br />'backup'<br />'delete'<br />'deletesas'<br />'get'<br />'getsas'<br />'list'<br />'listsas'<br />'purge'<br />'recover'<br />'regeneratekey'<br />'restore'<br />'set'<br />'setsas'<br />'update' |

### Sku

| Name | Description | Value |
| ---- | ----------- | ------------ |
| family | SKU family name | 'A' (required) |
| name | SKU name to specify whether the key vault is a standard vault or a premium vault. | 'premium'<br />'standard' (required) |

### VaultCreateOrUpdateParametersTags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VaultProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| accessPolicies | An array of 0 to 1024 identities that have access to the key vault. All identities in the array must use the same tenant ID as the key vault's tenant ID. When `createMode` is set to `recover`, access policies are not required. Otherwise, access policies are required. | [AccessPolicyEntry](#accesspolicyentry-2)[] |
| createMode | The vault's create mode to indicate whether the vault need to be recovered or not. | 'default'<br />'recover' |
| enabledForDeployment | Property to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault. | bool |
| enabledForDiskEncryption | Property to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. | bool |
| enabledForTemplateDeployment | Property to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault. | bool |
| enablePurgeProtection | Property specifying whether protection against purge is enabled for this vault. Setting this property to true activates protection against purge for this vault and its content - only the Key Vault service may initiate a hard, irrecoverable deletion. The setting is effective only if soft delete is also enabled. Enabling this functionality is irreversible - that is, the property does not accept false as its value. | bool |
| enableRbacAuthorization | Property that controls how data actions are authorized. When true, the key vault will use Role Based Access Control (RBAC) for authorization of data actions, and the access policies specified in vault properties will be  ignored. When false, the key vault will use the access policies specified in vault properties, and any policy stored on Azure Resource Manager will be ignored. If null or not specified, the vault is created with the default value of false. Note that management actions are always authorized with RBAC. | bool |
| enableSoftDelete | Property to specify whether the 'soft delete' functionality is enabled for this key vault. If it's not set to any value(true or false) when creating new key vault, it will be set to true by default. Once set to true, it cannot be reverted to false. | bool |
| networkAcls | Rules governing the accessibility of the key vault from specific network locations. | [NetworkRuleSet](#networkruleset-2) |
| provisioningState | Provisioning state of the vault. | 'RegisteringDns'<br />'Succeeded' |
| publicNetworkAccess | Property to specify whether the vault will accept traffic from public internet. If set to 'disabled' all traffic except private endpoint traffic and that that originates from trusted services will be blocked. This will override the set firewall rules, meaning that even if the firewall rules are present we will not honor the rules. | string |
| sku | SKU details | [Sku](#sku-2) (required) |
| softDeleteRetentionInDays | softDelete data retention days. It accepts &gt;=7 and &lt;=90. | int |
| tenantId | The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault. | string <br /><br />Constraints:<br />Min length = 36<br />Max length = 36<br />Pattern = `^[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}$` (required) |
| vaultUri | The URI of the vault for performing operations on keys and secrets. | string |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Full resource id of a vnet subnet, such as '/subscriptions/subid/resourceGroups/rg1/providers/Microsoft.Network/virtualNetworks/test-vnet/subnets/subnet1'. | string (required) |
| ignoreMissingVnetServiceEndpoint | Property to specify whether NRP will ignore the check if parent subnet has serviceEndpoints configured. | bool |

## Usage Examples
### Terraform Samples

A basic example of deploying Key Vault.

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
  default = "westeurope"
}

data "azurerm_client_config" "current" {
}

resource "azapi_resource" "resourceGroup" {
  type     = "Microsoft.Resources/resourceGroups@2020-06-01"
  name     = var.resource_name
  location = var.location
}

resource "azapi_resource" "vault" {
  type      = "Microsoft.KeyVault/vaults@2021-10-01"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    properties = {
      accessPolicies = [
        {
          objectId = data.azurerm_client_config.current.object_id
          permissions = {
            certificates = [
              "ManageContacts",
            ]
            keys = [
              "Create",
            ]
            secrets = [
              "Set",
            ]
            storage = [
            ]
          }
          tenantId = data.azurerm_client_config.current.tenant_id
        },
      ]
      createMode                   = "default"
      enableRbacAuthorization      = false
      enableSoftDelete             = true
      enabledForDeployment         = false
      enabledForDiskEncryption     = false
      enabledForTemplateDeployment = false
      publicNetworkAccess          = "Enabled"
      sku = {
        family = "A"
        name   = "standard"
      }
      softDeleteRetentionInDays = 7
      tenantId                  = data.azurerm_client_config.current.tenant_id
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Key Vault](https://github.com/Azure/terraform-azurerm-avm-res-keyvault-vault) | AVM Resource Module for Key Vault |


::: zone-end
