---
title: Microsoft.DocumentDB/databaseAccounts 2024-05-15
description: Azure Microsoft.DocumentDB/databaseAccounts syntax and properties to use in Azure Resource Manager templates for deploying the resource. API version 2024-05-15
zone_pivot_groups: deployment-languages-reference
ms.service: azure-resource-manager
ms.topic: reference
---
# Microsoft.DocumentDB databaseAccounts 2024-05-15

> [!div class="op_single_selector" title1="API Versions:"]
> - [Latest](../databaseaccounts.md)
> - [2025-11-01-preview](../2025-11-01-preview/databaseaccounts.md)
> - [2025-10-15](../2025-10-15/databaseaccounts.md)
> - [2025-05-01-preview](../2025-05-01-preview/databaseaccounts.md)
> - [2025-04-15](../2025-04-15/databaseaccounts.md)
> - [2024-12-01-preview](../2024-12-01-preview/databaseaccounts.md)
> - [2024-11-15](../2024-11-15/databaseaccounts.md)
> - [2024-09-01-preview](../2024-09-01-preview/databaseaccounts.md)
> - [2024-08-15](../2024-08-15/databaseaccounts.md)
> - [2024-05-15](../2024-05-15/databaseaccounts.md)
> - [2024-05-15-preview](../2024-05-15-preview/databaseaccounts.md)
> - [2024-02-15-preview](../2024-02-15-preview/databaseaccounts.md)
> - [2023-11-15](../2023-11-15/databaseaccounts.md)
> - [2023-11-15-preview](../2023-11-15-preview/databaseaccounts.md)
> - [2023-09-15](../2023-09-15/databaseaccounts.md)
> - [2023-09-15-preview](../2023-09-15-preview/databaseaccounts.md)
> - [2023-04-15](../2023-04-15/databaseaccounts.md)
> - [2023-03-15](../2023-03-15/databaseaccounts.md)
> - [2023-03-15-preview](../2023-03-15-preview/databaseaccounts.md)
> - [2023-03-01-preview](../2023-03-01-preview/databaseaccounts.md)
> - [2022-11-15](../2022-11-15/databaseaccounts.md)
> - [2022-11-15-preview](../2022-11-15-preview/databaseaccounts.md)
> - [2022-08-15](../2022-08-15/databaseaccounts.md)
> - [2022-08-15-preview](../2022-08-15-preview/databaseaccounts.md)
> - [2022-05-15](../2022-05-15/databaseaccounts.md)
> - [2022-05-15-preview](../2022-05-15-preview/databaseaccounts.md)
> - [2022-02-15-preview](../2022-02-15-preview/databaseaccounts.md)
> - [2021-11-15-preview](../2021-11-15-preview/databaseaccounts.md)
> - [2021-10-15](../2021-10-15/databaseaccounts.md)
> - [2021-10-15-preview](../2021-10-15-preview/databaseaccounts.md)
> - [2021-07-01-preview](../2021-07-01-preview/databaseaccounts.md)
> - [2021-06-15](../2021-06-15/databaseaccounts.md)
> - [2021-05-15](../2021-05-15/databaseaccounts.md)
> - [2021-04-15](../2021-04-15/databaseaccounts.md)
> - [2021-04-01-preview](../2021-04-01-preview/databaseaccounts.md)
> - [2021-03-15](../2021-03-15/databaseaccounts.md)
> - [2021-03-01-preview](../2021-03-01-preview/databaseaccounts.md)
> - [2021-01-15](../2021-01-15/databaseaccounts.md)
> - [2020-09-01](../2020-09-01/databaseaccounts.md)
> - [2020-06-01-preview](../2020-06-01-preview/databaseaccounts.md)
> - [2020-04-01](../2020-04-01/databaseaccounts.md)
> - [2020-03-01](../2020-03-01/databaseaccounts.md)
> - [2019-12-12](../2019-12-12/databaseaccounts.md)
> - [2019-08-01](../2019-08-01/databaseaccounts.md)
> - [2016-03-31](../2016-03-31/databaseaccounts.md)
> - [2016-03-19](../2016-03-19/databaseaccounts.md)
> - [2015-11-06](../2015-11-06/databaseaccounts.md)
> - [2015-04-08](../2015-04-08/databaseaccounts.md)
> - [2015-04-01](../2015-04-01/databaseaccounts.md)


::: zone pivot="deployment-language-bicep"

## Bicep resource definition

The databaseAccounts resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/bicep/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.documentdb/change-log/databaseaccounts.md).

## Resource format

To create a Microsoft.DocumentDB/databaseAccounts resource, add the following Bicep to your template.

```bicep
resource symbolicname 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' = {
  identity: {
    type: 'string'
    userAssignedIdentities: {
      {customized property}: {}
    }
  }
  kind: 'string'
  location: 'string'
  name: 'string'
  properties: {
    analyticalStorageConfiguration: {
      schemaType: 'string'
    }
    apiProperties: {
      serverVersion: 'string'
    }
    backupPolicy: {
      migrationState: {
        startTime: 'string'
        status: 'string'
        targetType: 'string'
      }
      type: 'string'
      // For remaining properties, see BackupPolicy objects
    }
    capabilities: [
      {
        name: 'string'
      }
    ]
    capacity: {
      totalThroughputLimit: int
    }
    connectorOffer: 'string'
    consistencyPolicy: {
      defaultConsistencyLevel: 'string'
      maxIntervalInSeconds: int
      maxStalenessPrefix: int
    }
    cors: [
      {
        allowedHeaders: 'string'
        allowedMethods: 'string'
        allowedOrigins: 'string'
        exposedHeaders: 'string'
        maxAgeInSeconds: int
      }
    ]
    createMode: 'string'
    customerManagedKeyStatus: 'string'
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'string'
    disableKeyBasedMetadataWriteAccess: bool
    disableLocalAuth: bool
    enableAnalyticalStorage: bool
    enableAutomaticFailover: bool
    enableBurstCapacity: bool
    enableCassandraConnector: bool
    enableFreeTier: bool
    enableMultipleWriteLocations: bool
    enablePartitionMerge: bool
    ipRules: [
      {
        ipAddressOrRange: 'string'
      }
    ]
    isVirtualNetworkFilterEnabled: bool
    keyVaultKeyUri: 'string'
    locations: [
      {
        failoverPriority: int
        isZoneRedundant: bool
        locationName: 'string'
      }
    ]
    minimalTlsVersion: 'string'
    networkAclBypass: 'string'
    networkAclBypassResourceIds: [
      'string'
    ]
    publicNetworkAccess: 'string'
    restoreParameters: {
      databasesToRestore: [
        {
          collectionNames: [
            'string'
          ]
          databaseName: 'string'
        }
      ]
      gremlinDatabasesToRestore: [
        {
          databaseName: 'string'
          graphNames: [
            'string'
          ]
        }
      ]
      restoreMode: 'string'
      restoreSource: 'string'
      restoreTimestampInUtc: 'string'
      tablesToRestore: [
        'string'
      ]
    }
    virtualNetworkRules: [
      {
        id: 'string'
        ignoreMissingVNetServiceEndpoint: bool
      }
    ]
  }
  tags: {
    {customized property}: 'string'
  }
}
```
### BackupPolicy objects

Set the **type** property to specify the type of object.

For **Continuous**, use:

```bicep
{
  continuousModeProperties: {
    tier: 'string'
  }
  type: 'Continuous'
}
```

For **Periodic**, use:

```bicep
{
  periodicModeProperties: {
    backupIntervalInMinutes: int
    backupRetentionIntervalInHours: int
    backupStorageRedundancy: 'string'
  }
  type: 'Periodic'
}
```

## Property Values
### Microsoft.DocumentDB/databaseAccounts

| Name | Description | Value |
| ---- | ----------- | ------------ |
| identity | Identity for the resource. | [ManagedServiceIdentity](#managedserviceidentity) |
| kind | Indicates the type of database account. This can only be set at database account creation. | 'GlobalDocumentDB'<br />'MongoDB'<br />'Parse' |
| location | The location of the resource group to which the resource belongs. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 3<br />Max length = 50<br />Pattern = `^[a-z0-9]+(-[a-z0-9]+)*` (required) |
| properties | Properties to create and update Azure Cosmos DB database accounts. | [DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties](#databaseaccountcreateupdatepropertiesordatabaseaccountgetproperties) (required) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |

### AnalyticalStorageConfiguration

| Name | Description | Value |
| ---- | ----------- | ------------ |
| schemaType | Describes the types of schema for analytical storage. | 'FullFidelity'<br />'WellDefined' |

### ApiProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| serverVersion | Describes the ServerVersion of an a MongoDB account. | '3.2'<br />'3.6'<br />'4.0'<br />'4.2'<br />'5.0'<br />'6.0' |

### BackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| migrationState | The object representing the state of the migration between the backup policies. | [BackupPolicyMigrationState](#backuppolicymigrationstate) |
| type | Set to 'Continuous' for type [ContinuousModeBackupPolicy](#continuousmodebackuppolicy). Set to 'Periodic' for type [PeriodicModeBackupPolicy](#periodicmodebackuppolicy). | 'Continuous'<br />'Periodic' (required) |

### BackupPolicyMigrationState

| Name | Description | Value |
| ---- | ----------- | ------------ |
| startTime | Time at which the backup policy migration started (ISO-8601 format). | string |
| status | Describes the status of migration between backup policy types. | 'Completed'<br />'Failed'<br />'InProgress'<br />'Invalid' |
| targetType | Describes the target backup policy type of the backup policy migration. | 'Continuous'<br />'Periodic' |

### Capability

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | Name of the Cosmos DB capability. For example, "name": "EnableCassandra". Current values also include "EnableTable" and "EnableGremlin". | string |

### Capacity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| totalThroughputLimit | The total throughput limit imposed on the account. A totalThroughputLimit of 2000 imposes a strict limit of max throughput that can be provisioned on that account to be 2000. A totalThroughputLimit of -1 indicates no limits on provisioning of throughput. | int <br /><br />Constraints:<br />Min value = -1 |

### Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ConsistencyPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| defaultConsistencyLevel | The default consistency level and configuration settings of the Cosmos DB account. | 'BoundedStaleness'<br />'ConsistentPrefix'<br />'Eventual'<br />'Session'<br />'Strong' (required) |
| maxIntervalInSeconds | When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 5<br />Max value = 86400 |
| maxStalenessPrefix | When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 1 – 2,147,483,647. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### ContinuousModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| continuousModeProperties | Configuration values for continuous mode backup | [ContinuousModeProperties](#continuousmodeproperties) |
| type | Describes the mode of backups. | 'Continuous' (required) |

### ContinuousModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| tier | Enum to indicate type of Continuous backup mode | 'Continuous30Days'<br />'Continuous7Days' |

### CorsPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| allowedHeaders | The request headers that the origin domain may specify on the CORS request. | string |
| allowedMethods | The methods (HTTP request verbs) that the origin domain may use for a CORS request. | string |
| allowedOrigins | The origin domains that are permitted to make a request against the service via CORS. | string (required) |
| exposedHeaders | The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer. | string |
| maxAgeInSeconds | The maximum amount time that a browser should cache the preflight OPTIONS request. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| analyticalStorageConfiguration | Analytical storage specific properties. | [AnalyticalStorageConfiguration](#analyticalstorageconfiguration) |
| apiProperties | API specific properties. Currently, supported only for MongoDB API. | [ApiProperties](#apiproperties) |
| backupPolicy | The object representing the policy for taking backups on an account. | [BackupPolicy](#backuppolicy) |
| capabilities | List of Cosmos DB capabilities for the account | [Capability](#capability)[] |
| capacity | The object that represents all properties related to capacity enforcement on an account. | [Capacity](#capacity) |
| connectorOffer | The cassandra connector offer type for the Cosmos DB database C* account. | 'Small' |
| consistencyPolicy | The consistency policy for the Cosmos DB account. | [ConsistencyPolicy](#consistencypolicy) |
| cors | The CORS policy for the Cosmos DB database account. | [CorsPolicy](#corspolicy)[] |
| createMode | Enum to indicate the mode of account creation. | 'Default'<br />'Restore' |
| customerManagedKeyStatus | Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance. | string |
| databaseAccountOfferType | The offer type for the database | 'Standard' (required) |
| defaultIdentity | The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more. | string |
| disableKeyBasedMetadataWriteAccess | Disable write operations on metadata resources (databases, containers, throughput) via account keys | bool |
| disableLocalAuth | Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication. | bool |
| enableAnalyticalStorage | Flag to indicate whether to enable storage analytics. | bool |
| enableAutomaticFailover | Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account. | bool |
| enableBurstCapacity | Flag to indicate enabling/disabling of Burst Capacity feature on the account | bool |
| enableCassandraConnector | Enables the cassandra connector on the Cosmos DB C* account | bool |
| enableFreeTier | Flag to indicate whether Free Tier is enabled. | bool |
| enableMultipleWriteLocations | Enables the account to write in multiple locations | bool |
| enablePartitionMerge | Flag to indicate enabling/disabling of Partition Merge feature on the account | bool |
| ipRules | List of IpRules. | [IpAddressOrRange](#ipaddressorrange)[] |
| isVirtualNetworkFilterEnabled | Flag to indicate whether to enable/disable Virtual Network ACL rules. | bool |
| keyVaultKeyUri | The URI of the key vault | string |
| locations | An array that contains the georeplication locations enabled for the Cosmos DB account. | [Location](#location)[] (required) |
| minimalTlsVersion | Indicates the minimum allowed Tls version. The default value is Tls 1.2. Cassandra and Mongo APIs only work with Tls 1.2. | 'Tls'<br />'Tls11'<br />'Tls12' |
| networkAclBypass | Indicates what services are allowed to bypass firewall checks. | 'AzureServices'<br />'None' |
| networkAclBypassResourceIds | An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account. | string[] |
| publicNetworkAccess | Whether requests from Public Network are allowed | 'Disabled'<br />'Enabled'<br />'SecuredByPerimeter' |
| restoreParameters | Parameters to indicate the information about the restore. | [RestoreParameters](#restoreparameters) |
| virtualNetworkRules | List of Virtual Network ACL rules configured for the Cosmos DB account. | [VirtualNetworkRule](#virtualnetworkrule)[] |

### DatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| collectionNames | The names of the collections available for restore. | string[] |
| databaseName | The name of the database available for restore. | string |

### GremlinDatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databaseName | The name of the gremlin database available for restore. | string |
| graphNames | The names of the graphs available for restore. | string[] |

### IpAddressOrRange

| Name | Description | Value |
| ---- | ----------- | ------------ |
| ipAddressOrRange | A single IPv4 address or a single IPv4 address range in CIDR format. Provided IPs must be well-formatted and cannot be contained in one of the following ranges: 10.0.0.0/8, 100.64.0.0/10, 172.16.0.0/12, 192.168.0.0/16, since these are not enforceable by the IP address filter. Example of valid inputs: “23.40.210.245” or “23.40.210.0/8”. | string |

### Location

| Name | Description | Value |
| ---- | ----------- | ------------ |
| failoverPriority | The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. | int <br /><br />Constraints:<br />Min value = 0 |
| isZoneRedundant | Flag to indicate whether or not this region is an AvailabilityZone region | bool |
| locationName | The name of the region. | string |

### ManagedServiceIdentity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| type | The type of identity used for the resource. The type 'SystemAssigned,UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service. | 'None'<br />'SystemAssigned'<br />'SystemAssigned,UserAssigned'<br />'UserAssigned' |
| userAssignedIdentities | The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'. | [ManagedServiceIdentityUserAssignedIdentities](#managedserviceidentityuserassignedidentities) |

### ManagedServiceIdentityUserAssignedIdentities

| Name | Description | Value |
| ---- | ----------- | ------------ |

### PeriodicModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| periodicModeProperties | Configuration values for periodic mode backup | [PeriodicModeProperties](#periodicmodeproperties) |
| type | Describes the mode of backups. | 'Periodic' (required) |

### PeriodicModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| backupIntervalInMinutes | An integer representing the interval in minutes between two backups | int <br /><br />Constraints:<br />Min value = 0 |
| backupRetentionIntervalInHours | An integer representing the time (in hours) that each backup is retained | int <br /><br />Constraints:<br />Min value = 0 |
| backupStorageRedundancy | Enum to indicate type of backup residency | 'Geo'<br />'Local'<br />'Zone' |

### RestoreParameters

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databasesToRestore | List of specific databases available for restore. | [DatabaseRestoreResource](#databaserestoreresource)[] |
| gremlinDatabasesToRestore | List of specific gremlin databases available for restore. | [GremlinDatabaseRestoreResource](#gremlindatabaserestoreresource)[] |
| restoreMode | Describes the mode of the restore. | 'PointInTime' |
| restoreSource | The id of the restorable database account from which the restore has to be initiated. For example: /subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName} | string |
| restoreTimestampInUtc | Time to which the account has to be restored (ISO-8601 format). | string |
| tablesToRestore | List of specific tables available for restore. | string[] |

### Tags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}. | string |
| ignoreMissingVNetServiceEndpoint | Create firewall rule before the virtual network has vnet service endpoint enabled. | bool |

## Usage Examples
### Bicep Samples

A basic example of deploying CosmosDB (formally DocumentDB) Account.

```bicep
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAutomaticFailover: false
    locations: [
      {
        isZoneRedundant: false
        locationName: 'West Europe'
        failoverPriority: 0
      }
    ]
    networkAclBypass: 'None'
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    defaultIdentity: 'FirstPartyIdentity'
    isVirtualNetworkFilterEnabled: false
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    publicNetworkAccess: 'Enabled'
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
  }
}
```
### Azure Verified Modules

The following [Azure Verified Modules](https://aka.ms/avm) can be used to deploy this resource type.

> [!div class="mx-tableFixed"]
> | Module | Description |
> | ----- | ----- |
> | [Cosmos DB Database Account](https://github.com/Azure/bicep-registry-modules/tree/main/avm/res/document-db/database-account) | AVM Resource Module for Cosmos DB Database Account |

### Azure Quickstart Samples

The following [Azure Quickstart templates](https://aka.ms/azqst) contain Bicep samples for deploying this resource type.

> [!div class="mx-tableFixed"]
> | Bicep File | Description |
> | ----- | ----- |
> | [Azure Cosmos DB account SQL API with analytical store](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-analytical-store/main.bicep) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container configured with analytical store. |
> | [Azure Cosmos DB Account with Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/documentdb-webapp/main.bicep) | This template deploys an Azure Cosmos DB account, an App Service Plan, and creates a Web App in the App Service Plan. It also adds two Application settings to the Web App that reference the Azure Cosmos DB account endpoint. This way solutions deployed to the Web App can connect to the Azure Cosmos DB account endpoint using those settings. |
> | [Create a Cosmos DB account with Microsoft Defender enabled](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/microsoft-defender-cosmosdb-create-account/main.bicep) | Using this ARM template, you can deploy an Azure Cosmos DB account with Microsoft Defender for Azure Cosmos DB enabled. Microsoft Defender for Azure Cosmos DB is an Azure-native layer of security that detects attempts to exploit databases in your Azure Cosmos DB accounts. Microsoft Defender for Azure Cosmos DB detects potential SQL injections, known bad actors based on Microsoft Threat Intelligence, suspicious access patterns, and potential exploitations of your database through compromised identities or malicious insiders. |
> | [Create a free-tier Azure Cosmos DB account](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-free/main.bicep) | This template creates a free-tier Azure Cosmos DB account for SQL API with a database with shared throughput and container. |
> | [Create a minimal Azure Cosmos DB account for Core (SQL) API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-minimal/main.bicep) | This template creates an Azure Cosmos DB account for the Core (SQL) API while only specifying the minimal required resource properties. |
> | [Create a Serverless Azure Cosmos DB account for SQL API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-serverless/main.bicep) | This template creates an serverless Azure Cosmos DB account for the Core (SQL) API. |
> | [Create a zero touch Azure Cosmos account and Azure Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-webapp/main.bicep) | This template creates an Azure Cosmos account, injects the Cosmos DB endpoint and keys into Azure Web App settings, then deploys an ASP MVC web app from GitHub. |
> | [Create an Azure Cosmos account for MongoDB API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-mongodb/main.bicep) | This template creates an Azure Cosmos DB account for MongoDB API 4.2 in two regions using shared and dedicated throughput with two collections. |
> | [Create an Azure Cosmos account for MongoDB API autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-mongodb-autoscale/main.bicep) | This template creates an Azure Cosmos DB account for MongoDB API 4.2 in two regions using both shared and dedicated autoscale throughput. |
> | [Create an Azure Cosmos account for Table API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-table/main.bicep) | This template creates an Azure Cosmos DB account for Table API in two regions and a single table with provisioned throughput. |
> | [Create an Azure Cosmos account for Table API with autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-table-autoscale/main.bicep) | This template creates an Azure Cosmos DB account for Table API in two regions and a single table with autoscale throughput. |
> | [Create an Azure Cosmos DB account for Cassandra API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-cassandra/main.bicep) | This template creates an Azure Cosmos DB account for Cassandra API in two regions with a keyspace and table with dedicated throughput. |
> | [Create an Azure Cosmos DB account for Core (SQL) API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql/main.bicep) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container with throughput with multiple other options. |
> | [Create an Azure Cosmos DB account for Gremlin API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-gremlin/main.bicep) | This template creates an Azure Cosmos DB account for Gremlin API in two regions with one database and one graph using dedicated throughput. |
> | [Create an Azure Cosmos DB account for Gremlin API autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-gremlin-autoscale/main.bicep) | This template creates an Azure Cosmos DB account for Gremlin API in two regions with one database and one graph using autoscale throughput. |
> | [Create an Azure Cosmos DB account in multiple regions](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-create-multi-region-account/main.bicep) | This template creates an Azure Cosmos DB account for any database API type with a primary and secondary region with choice of consistency level and failover type. |
> | [Create an Azure Cosmos DB account SQL API with autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-autoscale/main.bicep) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container with autoscale throughput with multiple other options. |
> | [Create an Azure Cosmos DB Account with a private endpoint](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-private-endpoint/main.bicep) | This template will create a Cosmos account, a virtual network and a private endpoint exposing the Cosmos account to the virtual network. |
> | [Create an Azure Cosmos DB SQL Account with data plane RBAC](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-rbac/main.bicep) | This template will create a SQL Cosmos account, a natively maintained Role Definition, and a natively maintained Role Assignment for an AAD identity. |
> | [Create an Azure CosmosDB Account](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-create-account/main.bicep) | This ARM template is intented to create a CosmosDB Account quickly with the minimal required values |
> | [Create autoscale Azure Cosmos DB account for Cassandra API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-cassandra-autoscale/main.bicep) | This template creates an Azure Cosmos DB account for Cassandra API in two regions with a keyspace and table with autoscale throughput. |
> | [Create Azure Cosmos DB Core (SQL) API stored procedures](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-container-sprocs/main.bicep) | This template creates an Azure Cosmos DB account for Core (SQL) API and a container with a stored procedure, trigger and user defined function. |
> | [Creates a Dapr microservices app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-blob/main.bicep) | Create a Dapr microservices app using Container Apps. |
> | [Creates a Dapr pub-sub servicebus app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-pubsub-servicebus/main.bicep) | Create a Dapr pub-sub servicebus app using Container Apps. |
> | [Deploy Azure Data Explorer DB with Cosmos DB connection](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.kusto/kusto-cosmos-db/main.bicep) | Deploy Azure Data Explorer DB with Cosmos DB connection. |


::: zone-end

::: zone pivot="deployment-language-arm-template"

## ARM template resource definition

The databaseAccounts resource type can be deployed with operations that target: 

* **Resource groups** - See [resource group deployment commands](/azure/azure-resource-manager/templates/deploy-to-resource-group)

For a list of changed properties in each API version, see [change log](~/microsoft.documentdb/change-log/databaseaccounts.md).

## Resource format

To create a Microsoft.DocumentDB/databaseAccounts resource, add the following JSON to your template.

```json
{
  "type": "Microsoft.DocumentDB/databaseAccounts",
  "apiVersion": "2024-05-15",
  "name": "string",
  "identity": {
    "type": "string",
    "userAssignedIdentities": {
      "{customized property}": {
      }
    }
  },
  "kind": "string",
  "location": "string",
  "properties": {
    "analyticalStorageConfiguration": {
      "schemaType": "string"
    },
    "apiProperties": {
      "serverVersion": "string"
    },
    "backupPolicy": {
      "migrationState": {
        "startTime": "string",
        "status": "string",
        "targetType": "string"
      },
      "type": "string"
      // For remaining properties, see BackupPolicy objects
    },
    "capabilities": [
      {
        "name": "string"
      }
    ],
    "capacity": {
      "totalThroughputLimit": "int"
    },
    "connectorOffer": "string",
    "consistencyPolicy": {
      "defaultConsistencyLevel": "string",
      "maxIntervalInSeconds": "int",
      "maxStalenessPrefix": "int"
    },
    "cors": [
      {
        "allowedHeaders": "string",
        "allowedMethods": "string",
        "allowedOrigins": "string",
        "exposedHeaders": "string",
        "maxAgeInSeconds": "int"
      }
    ],
    "createMode": "string",
    "customerManagedKeyStatus": "string",
    "databaseAccountOfferType": "Standard",
    "defaultIdentity": "string",
    "disableKeyBasedMetadataWriteAccess": "bool",
    "disableLocalAuth": "bool",
    "enableAnalyticalStorage": "bool",
    "enableAutomaticFailover": "bool",
    "enableBurstCapacity": "bool",
    "enableCassandraConnector": "bool",
    "enableFreeTier": "bool",
    "enableMultipleWriteLocations": "bool",
    "enablePartitionMerge": "bool",
    "ipRules": [
      {
        "ipAddressOrRange": "string"
      }
    ],
    "isVirtualNetworkFilterEnabled": "bool",
    "keyVaultKeyUri": "string",
    "locations": [
      {
        "failoverPriority": "int",
        "isZoneRedundant": "bool",
        "locationName": "string"
      }
    ],
    "minimalTlsVersion": "string",
    "networkAclBypass": "string",
    "networkAclBypassResourceIds": [ "string" ],
    "publicNetworkAccess": "string",
    "restoreParameters": {
      "databasesToRestore": [
        {
          "collectionNames": [ "string" ],
          "databaseName": "string"
        }
      ],
      "gremlinDatabasesToRestore": [
        {
          "databaseName": "string",
          "graphNames": [ "string" ]
        }
      ],
      "restoreMode": "string",
      "restoreSource": "string",
      "restoreTimestampInUtc": "string",
      "tablesToRestore": [ "string" ]
    },
    "virtualNetworkRules": [
      {
        "id": "string",
        "ignoreMissingVNetServiceEndpoint": "bool"
      }
    ]
  },
  "tags": {
    "{customized property}": "string"
  }
}
```
### BackupPolicy objects

Set the **type** property to specify the type of object.

For **Continuous**, use:

```json
{
  "continuousModeProperties": {
    "tier": "string"
  },
  "type": "Continuous"
}
```

For **Periodic**, use:

```json
{
  "periodicModeProperties": {
    "backupIntervalInMinutes": "int",
    "backupRetentionIntervalInHours": "int",
    "backupStorageRedundancy": "string"
  },
  "type": "Periodic"
}
```

## Property Values
### Microsoft.DocumentDB/databaseAccounts

| Name | Description | Value |
| ---- | ----------- | ------------ |
| apiVersion | The api version | '2024-05-15' |
| identity | Identity for the resource. | [ManagedServiceIdentity](#managedserviceidentity-1) |
| kind | Indicates the type of database account. This can only be set at database account creation. | 'GlobalDocumentDB'<br />'MongoDB'<br />'Parse' |
| location | The location of the resource group to which the resource belongs. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 3<br />Max length = 50<br />Pattern = `^[a-z0-9]+(-[a-z0-9]+)*` (required) |
| properties | Properties to create and update Azure Cosmos DB database accounts. | [DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties](#databaseaccountcreateupdatepropertiesordatabaseaccountgetproperties-1) (required) |
| tags | Resource tags | Dictionary of tag names and values. See [Tags in templates](/azure/azure-resource-manager/management/tag-resources#arm-templates) |
| type | The resource type | 'Microsoft.DocumentDB/databaseAccounts' |

### AnalyticalStorageConfiguration

| Name | Description | Value |
| ---- | ----------- | ------------ |
| schemaType | Describes the types of schema for analytical storage. | 'FullFidelity'<br />'WellDefined' |

### ApiProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| serverVersion | Describes the ServerVersion of an a MongoDB account. | '3.2'<br />'3.6'<br />'4.0'<br />'4.2'<br />'5.0'<br />'6.0' |

### BackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| migrationState | The object representing the state of the migration between the backup policies. | [BackupPolicyMigrationState](#backuppolicymigrationstate-1) |
| type | Set to 'Continuous' for type [ContinuousModeBackupPolicy](#continuousmodebackuppolicy-1). Set to 'Periodic' for type [PeriodicModeBackupPolicy](#periodicmodebackuppolicy-1). | 'Continuous'<br />'Periodic' (required) |

### BackupPolicyMigrationState

| Name | Description | Value |
| ---- | ----------- | ------------ |
| startTime | Time at which the backup policy migration started (ISO-8601 format). | string |
| status | Describes the status of migration between backup policy types. | 'Completed'<br />'Failed'<br />'InProgress'<br />'Invalid' |
| targetType | Describes the target backup policy type of the backup policy migration. | 'Continuous'<br />'Periodic' |

### Capability

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | Name of the Cosmos DB capability. For example, "name": "EnableCassandra". Current values also include "EnableTable" and "EnableGremlin". | string |

### Capacity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| totalThroughputLimit | The total throughput limit imposed on the account. A totalThroughputLimit of 2000 imposes a strict limit of max throughput that can be provisioned on that account to be 2000. A totalThroughputLimit of -1 indicates no limits on provisioning of throughput. | int <br /><br />Constraints:<br />Min value = -1 |

### Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ConsistencyPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| defaultConsistencyLevel | The default consistency level and configuration settings of the Cosmos DB account. | 'BoundedStaleness'<br />'ConsistentPrefix'<br />'Eventual'<br />'Session'<br />'Strong' (required) |
| maxIntervalInSeconds | When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 5<br />Max value = 86400 |
| maxStalenessPrefix | When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 1 – 2,147,483,647. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### ContinuousModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| continuousModeProperties | Configuration values for continuous mode backup | [ContinuousModeProperties](#continuousmodeproperties-1) |
| type | Describes the mode of backups. | 'Continuous' (required) |

### ContinuousModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| tier | Enum to indicate type of Continuous backup mode | 'Continuous30Days'<br />'Continuous7Days' |

### CorsPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| allowedHeaders | The request headers that the origin domain may specify on the CORS request. | string |
| allowedMethods | The methods (HTTP request verbs) that the origin domain may use for a CORS request. | string |
| allowedOrigins | The origin domains that are permitted to make a request against the service via CORS. | string (required) |
| exposedHeaders | The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer. | string |
| maxAgeInSeconds | The maximum amount time that a browser should cache the preflight OPTIONS request. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| analyticalStorageConfiguration | Analytical storage specific properties. | [AnalyticalStorageConfiguration](#analyticalstorageconfiguration-1) |
| apiProperties | API specific properties. Currently, supported only for MongoDB API. | [ApiProperties](#apiproperties-1) |
| backupPolicy | The object representing the policy for taking backups on an account. | [BackupPolicy](#backuppolicy-1) |
| capabilities | List of Cosmos DB capabilities for the account | [Capability](#capability-1)[] |
| capacity | The object that represents all properties related to capacity enforcement on an account. | [Capacity](#capacity-1) |
| connectorOffer | The cassandra connector offer type for the Cosmos DB database C* account. | 'Small' |
| consistencyPolicy | The consistency policy for the Cosmos DB account. | [ConsistencyPolicy](#consistencypolicy-1) |
| cors | The CORS policy for the Cosmos DB database account. | [CorsPolicy](#corspolicy-1)[] |
| createMode | Enum to indicate the mode of account creation. | 'Default'<br />'Restore' |
| customerManagedKeyStatus | Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance. | string |
| databaseAccountOfferType | The offer type for the database | 'Standard' (required) |
| defaultIdentity | The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more. | string |
| disableKeyBasedMetadataWriteAccess | Disable write operations on metadata resources (databases, containers, throughput) via account keys | bool |
| disableLocalAuth | Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication. | bool |
| enableAnalyticalStorage | Flag to indicate whether to enable storage analytics. | bool |
| enableAutomaticFailover | Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account. | bool |
| enableBurstCapacity | Flag to indicate enabling/disabling of Burst Capacity feature on the account | bool |
| enableCassandraConnector | Enables the cassandra connector on the Cosmos DB C* account | bool |
| enableFreeTier | Flag to indicate whether Free Tier is enabled. | bool |
| enableMultipleWriteLocations | Enables the account to write in multiple locations | bool |
| enablePartitionMerge | Flag to indicate enabling/disabling of Partition Merge feature on the account | bool |
| ipRules | List of IpRules. | [IpAddressOrRange](#ipaddressorrange-1)[] |
| isVirtualNetworkFilterEnabled | Flag to indicate whether to enable/disable Virtual Network ACL rules. | bool |
| keyVaultKeyUri | The URI of the key vault | string |
| locations | An array that contains the georeplication locations enabled for the Cosmos DB account. | [Location](#location-1)[] (required) |
| minimalTlsVersion | Indicates the minimum allowed Tls version. The default value is Tls 1.2. Cassandra and Mongo APIs only work with Tls 1.2. | 'Tls'<br />'Tls11'<br />'Tls12' |
| networkAclBypass | Indicates what services are allowed to bypass firewall checks. | 'AzureServices'<br />'None' |
| networkAclBypassResourceIds | An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account. | string[] |
| publicNetworkAccess | Whether requests from Public Network are allowed | 'Disabled'<br />'Enabled'<br />'SecuredByPerimeter' |
| restoreParameters | Parameters to indicate the information about the restore. | [RestoreParameters](#restoreparameters-1) |
| virtualNetworkRules | List of Virtual Network ACL rules configured for the Cosmos DB account. | [VirtualNetworkRule](#virtualnetworkrule-1)[] |

### DatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| collectionNames | The names of the collections available for restore. | string[] |
| databaseName | The name of the database available for restore. | string |

### GremlinDatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databaseName | The name of the gremlin database available for restore. | string |
| graphNames | The names of the graphs available for restore. | string[] |

### IpAddressOrRange

| Name | Description | Value |
| ---- | ----------- | ------------ |
| ipAddressOrRange | A single IPv4 address or a single IPv4 address range in CIDR format. Provided IPs must be well-formatted and cannot be contained in one of the following ranges: 10.0.0.0/8, 100.64.0.0/10, 172.16.0.0/12, 192.168.0.0/16, since these are not enforceable by the IP address filter. Example of valid inputs: “23.40.210.245” or “23.40.210.0/8”. | string |

### Location

| Name | Description | Value |
| ---- | ----------- | ------------ |
| failoverPriority | The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. | int <br /><br />Constraints:<br />Min value = 0 |
| isZoneRedundant | Flag to indicate whether or not this region is an AvailabilityZone region | bool |
| locationName | The name of the region. | string |

### ManagedServiceIdentity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| type | The type of identity used for the resource. The type 'SystemAssigned,UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service. | 'None'<br />'SystemAssigned'<br />'SystemAssigned,UserAssigned'<br />'UserAssigned' |
| userAssignedIdentities | The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'. | [ManagedServiceIdentityUserAssignedIdentities](#managedserviceidentityuserassignedidentities-1) |

### ManagedServiceIdentityUserAssignedIdentities

| Name | Description | Value |
| ---- | ----------- | ------------ |

### PeriodicModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| periodicModeProperties | Configuration values for periodic mode backup | [PeriodicModeProperties](#periodicmodeproperties-1) |
| type | Describes the mode of backups. | 'Periodic' (required) |

### PeriodicModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| backupIntervalInMinutes | An integer representing the interval in minutes between two backups | int <br /><br />Constraints:<br />Min value = 0 |
| backupRetentionIntervalInHours | An integer representing the time (in hours) that each backup is retained | int <br /><br />Constraints:<br />Min value = 0 |
| backupStorageRedundancy | Enum to indicate type of backup residency | 'Geo'<br />'Local'<br />'Zone' |

### RestoreParameters

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databasesToRestore | List of specific databases available for restore. | [DatabaseRestoreResource](#databaserestoreresource-1)[] |
| gremlinDatabasesToRestore | List of specific gremlin databases available for restore. | [GremlinDatabaseRestoreResource](#gremlindatabaserestoreresource-1)[] |
| restoreMode | Describes the mode of the restore. | 'PointInTime' |
| restoreSource | The id of the restorable database account from which the restore has to be initiated. For example: /subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName} | string |
| restoreTimestampInUtc | Time to which the account has to be restored (ISO-8601 format). | string |
| tablesToRestore | List of specific tables available for restore. | string[] |

### Tags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}. | string |
| ignoreMissingVNetServiceEndpoint | Create firewall rule before the virtual network has vnet service endpoint enabled. | bool |

## Usage Examples
### Azure Quickstart Templates

The following [Azure Quickstart templates](https://aka.ms/azqst) deploy this resource type.

> [!div class="mx-tableFixed"]
> | Template | Description |
> | ----- | ----- |
> | [Azure Cosmos DB account SQL API with analytical store](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-analytical-store)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-analytical-store%2Fazuredeploy.json) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container configured with analytical store. |
> | [Azure Cosmos DB Account with Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/documentdb-webapp)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.web%2Fdocumentdb-webapp%2Fazuredeploy.json) | This template deploys an Azure Cosmos DB account, an App Service Plan, and creates a Web App in the App Service Plan. It also adds two Application settings to the Web App that reference the Azure Cosmos DB account endpoint. This way solutions deployed to the Web App can connect to the Azure Cosmos DB account endpoint using those settings. |
> | [CI/CD using Jenkins on Azure Container Service (AKS)](https://github.com/Azure/azure-quickstart-templates/tree/master/application-workloads/jenkins/jenkins-cicd-container)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fapplication-workloads%2Fjenkins%2Fjenkins-cicd-container%2Fazuredeploy.json) | Containers make it very easy for you to continuously build and deploy your applications. By orchestrating deployment of those containers using Kubernetes in Azure Container Service, you can achieve replicable, manageable clusters of containers. By setting up a continuous build to produce your container images and orchestration, you can increase the speed and reliability of your deployment. |
> | [Create a Cosmos DB account with Microsoft Defender enabled](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/microsoft-defender-cosmosdb-create-account)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fmicrosoft-defender-cosmosdb-create-account%2Fazuredeploy.json) | Using this ARM template, you can deploy an Azure Cosmos DB account with Microsoft Defender for Azure Cosmos DB enabled. Microsoft Defender for Azure Cosmos DB is an Azure-native layer of security that detects attempts to exploit databases in your Azure Cosmos DB accounts. Microsoft Defender for Azure Cosmos DB detects potential SQL injections, known bad actors based on Microsoft Threat Intelligence, suspicious access patterns, and potential exploitations of your database through compromised identities or malicious insiders. |
> | [Create a free-tier Azure Cosmos DB account](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-free)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-free%2Fazuredeploy.json) | This template creates a free-tier Azure Cosmos DB account for SQL API with a database with shared throughput and container. |
> | [Create a minimal Azure Cosmos DB account for Core (SQL) API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-minimal)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-minimal%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for the Core (SQL) API while only specifying the minimal required resource properties. |
> | [Create a Serverless Azure Cosmos DB account for SQL API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-serverless)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-serverless%2Fazuredeploy.json) | This template creates an serverless Azure Cosmos DB account for the Core (SQL) API. |
> | [Create a zero touch Azure Cosmos account and Azure Web App](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-webapp)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-webapp%2Fazuredeploy.json) | This template creates an Azure Cosmos account, injects the Cosmos DB endpoint and keys into Azure Web App settings, then deploys an ASP MVC web app from GitHub. |
> | [Create an Azure Cosmos account for MongoDB API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-mongodb)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-mongodb%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for MongoDB API 4.2 in two regions using shared and dedicated throughput with two collections. |
> | [Create an Azure Cosmos account for MongoDB API autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-mongodb-autoscale)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-mongodb-autoscale%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for MongoDB API 4.2 in two regions using both shared and dedicated autoscale throughput. |
> | [Create an Azure Cosmos account for Table API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-table)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-table%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Table API in two regions and a single table with provisioned throughput. |
> | [Create an Azure Cosmos account for Table API with autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-table-autoscale)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-table-autoscale%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Table API in two regions and a single table with autoscale throughput. |
> | [Create an Azure Cosmos DB account for Cassandra API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-cassandra)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-cassandra%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Cassandra API in two regions with a keyspace and table with dedicated throughput. |
> | [Create an Azure Cosmos DB account for Core (SQL) API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql%2Fazuredeploy.json) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container with throughput with multiple other options. |
> | [Create an Azure Cosmos DB account for Gremlin API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-gremlin)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-gremlin%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Gremlin API in two regions with one database and one graph using dedicated throughput. |
> | [Create an Azure Cosmos DB account for Gremlin API autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-gremlin-autoscale)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-gremlin-autoscale%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Gremlin API in two regions with one database and one graph using autoscale throughput. |
> | [Create an Azure Cosmos DB account in multiple regions](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-create-multi-region-account)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-create-multi-region-account%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for any database API type with a primary and secondary region with choice of consistency level and failover type. |
> | [Create an Azure Cosmos DB account SQL API with autoscale](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-autoscale)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-autoscale%2Fazuredeploy.json) | This template creates an Azure Cosmos account for Core (SQL) API with a database and container with autoscale throughput with multiple other options. |
> | [Create an Azure Cosmos DB Account with a private endpoint](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-private-endpoint)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-private-endpoint%2Fazuredeploy.json) | This template will create a Cosmos account, a virtual network and a private endpoint exposing the Cosmos account to the virtual network. |
> | [Create an Azure Cosmos DB SQL Account with data plane RBAC](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-rbac)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-rbac%2Fazuredeploy.json) | This template will create a SQL Cosmos account, a natively maintained Role Definition, and a natively maintained Role Assignment for an AAD identity. |
> | [Create an Azure CosmosDB Account](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-create-account)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-create-account%2Fazuredeploy.json) | This ARM template is intented to create a CosmosDB Account quickly with the minimal required values |
> | [Create autoscale Azure Cosmos DB account for Cassandra API](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-cassandra-autoscale)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-cassandra-autoscale%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Cassandra API in two regions with a keyspace and table with autoscale throughput. |
> | [Create Azure Cosmos DB Core (SQL) API stored procedures](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-container-sprocs)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-container-sprocs%2Fazuredeploy.json) | This template creates an Azure Cosmos DB account for Core (SQL) API and a container with a stored procedure, trigger and user defined function. |
> | [Create Azure Cosmos with SQL API and multiple containers](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.documentdb/cosmosdb-sql-multiple-containers)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.documentdb%2Fcosmosdb-sql-multiple-containers%2Fazuredeploy.json) | The template creates a Cosmos container with a SQL API and allows adding mulitple containers. |
> | [Creates a Dapr microservices app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-blob)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.app%2Fcontainer-app-dapr-blob%2Fazuredeploy.json) | Create a Dapr microservices app using Container Apps. |
> | [Creates a Dapr pub-sub servicebus app using Container Apps](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.app/container-app-dapr-pubsub-servicebus)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.app%2Fcontainer-app-dapr-pubsub-servicebus%2Fazuredeploy.json) | Create a Dapr pub-sub servicebus app using Container Apps. |
> | [Deploy Azure Data Explorer DB with Cosmos DB connection](https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.kusto/kusto-cosmos-db)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fquickstarts%2Fmicrosoft.kusto%2Fkusto-cosmos-db%2Fazuredeploy.json) | Deploy Azure Data Explorer DB with Cosmos DB connection. |
> | [Web App with a SQL Database, Azure Cosmos DB, Azure Search](https://github.com/Azure/azure-quickstart-templates/tree/master/demos/web-app-sql-docdb-search)<br><br>[![Deploy to Azure](~/media/deploy-to-azure.svg)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FAzure%2Fazure-quickstart-templates%2Fmaster%2Fdemos%2Fweb-app-sql-docdb-search%2Fazuredeploy.json) | This template provisions a Web App, a SQL Database, Azure Cosmos DB, Azure Search and Application Insights.  |


::: zone-end

::: zone pivot="deployment-language-terraform"

## Terraform (AzAPI provider) resource definition

The databaseAccounts resource type can be deployed with operations that target: 

* **Resource groups**

For a list of changed properties in each API version, see [change log](~/microsoft.documentdb/change-log/databaseaccounts.md).

## Resource format

To create a Microsoft.DocumentDB/databaseAccounts resource, add the following Terraform to your template.

```terraform
resource "azapi_resource" "symbolicname" {
  type = "Microsoft.DocumentDB/databaseAccounts@2024-05-15"
  name = "string"
  parent_id = "string"
  identity {
    type = "string"
    identity_ids = [
      "string"
    ]
  }
  location = "string"
  tags = {
    {customized property} = "string"
  }
  body = {
    kind = "string"
    properties = {
      analyticalStorageConfiguration = {
        schemaType = "string"
      }
      apiProperties = {
        serverVersion = "string"
      }
      backupPolicy = {
        migrationState = {
          startTime = "string"
          status = "string"
          targetType = "string"
        }
        type = "string"
        // For remaining properties, see BackupPolicy objects
      }
      capabilities = [
        {
          name = "string"
        }
      ]
      capacity = {
        totalThroughputLimit = int
      }
      connectorOffer = "string"
      consistencyPolicy = {
        defaultConsistencyLevel = "string"
        maxIntervalInSeconds = int
        maxStalenessPrefix = int
      }
      cors = [
        {
          allowedHeaders = "string"
          allowedMethods = "string"
          allowedOrigins = "string"
          exposedHeaders = "string"
          maxAgeInSeconds = int
        }
      ]
      createMode = "string"
      customerManagedKeyStatus = "string"
      databaseAccountOfferType = "Standard"
      defaultIdentity = "string"
      disableKeyBasedMetadataWriteAccess = bool
      disableLocalAuth = bool
      enableAnalyticalStorage = bool
      enableAutomaticFailover = bool
      enableBurstCapacity = bool
      enableCassandraConnector = bool
      enableFreeTier = bool
      enableMultipleWriteLocations = bool
      enablePartitionMerge = bool
      ipRules = [
        {
          ipAddressOrRange = "string"
        }
      ]
      isVirtualNetworkFilterEnabled = bool
      keyVaultKeyUri = "string"
      locations = [
        {
          failoverPriority = int
          isZoneRedundant = bool
          locationName = "string"
        }
      ]
      minimalTlsVersion = "string"
      networkAclBypass = "string"
      networkAclBypassResourceIds = [
        "string"
      ]
      publicNetworkAccess = "string"
      restoreParameters = {
        databasesToRestore = [
          {
            collectionNames = [
              "string"
            ]
            databaseName = "string"
          }
        ]
        gremlinDatabasesToRestore = [
          {
            databaseName = "string"
            graphNames = [
              "string"
            ]
          }
        ]
        restoreMode = "string"
        restoreSource = "string"
        restoreTimestampInUtc = "string"
        tablesToRestore = [
          "string"
        ]
      }
      virtualNetworkRules = [
        {
          id = "string"
          ignoreMissingVNetServiceEndpoint = bool
        }
      ]
    }
  }
}
```
### BackupPolicy objects

Set the **type** property to specify the type of object.

For **Continuous**, use:

```terraform
{
  continuousModeProperties = {
    tier = "string"
  }
  type = "Continuous"
}
```

For **Periodic**, use:

```terraform
{
  periodicModeProperties = {
    backupIntervalInMinutes = int
    backupRetentionIntervalInHours = int
    backupStorageRedundancy = "string"
  }
  type = "Periodic"
}
```

## Property Values
### Microsoft.DocumentDB/databaseAccounts

| Name | Description | Value |
| ---- | ----------- | ------------ |
| identity | Identity for the resource. | [ManagedServiceIdentity](#managedserviceidentity-2) |
| kind | Indicates the type of database account. This can only be set at database account creation. | 'GlobalDocumentDB'<br />'MongoDB'<br />'Parse' |
| location | The location of the resource group to which the resource belongs. | string |
| name | The resource name | string <br /><br />Constraints:<br />Min length = 3<br />Max length = 50<br />Pattern = `^[a-z0-9]+(-[a-z0-9]+)*` (required) |
| properties | Properties to create and update Azure Cosmos DB database accounts. | [DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties](#databaseaccountcreateupdatepropertiesordatabaseaccountgetproperties-2) (required) |
| tags | Resource tags | Dictionary of tag names and values. |
| type | The resource type | "Microsoft.DocumentDB/databaseAccounts@2024-05-15" |

### AnalyticalStorageConfiguration

| Name | Description | Value |
| ---- | ----------- | ------------ |
| schemaType | Describes the types of schema for analytical storage. | 'FullFidelity'<br />'WellDefined' |

### ApiProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| serverVersion | Describes the ServerVersion of an a MongoDB account. | '3.2'<br />'3.6'<br />'4.0'<br />'4.2'<br />'5.0'<br />'6.0' |

### BackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| migrationState | The object representing the state of the migration between the backup policies. | [BackupPolicyMigrationState](#backuppolicymigrationstate-2) |
| type | Set to 'Continuous' for type [ContinuousModeBackupPolicy](#continuousmodebackuppolicy-2). Set to 'Periodic' for type [PeriodicModeBackupPolicy](#periodicmodebackuppolicy-2). | 'Continuous'<br />'Periodic' (required) |

### BackupPolicyMigrationState

| Name | Description | Value |
| ---- | ----------- | ------------ |
| startTime | Time at which the backup policy migration started (ISO-8601 format). | string |
| status | Describes the status of migration between backup policy types. | 'Completed'<br />'Failed'<br />'InProgress'<br />'Invalid' |
| targetType | Describes the target backup policy type of the backup policy migration. | 'Continuous'<br />'Periodic' |

### Capability

| Name | Description | Value |
| ---- | ----------- | ------------ |
| name | Name of the Cosmos DB capability. For example, "name": "EnableCassandra". Current values also include "EnableTable" and "EnableGremlin". | string |

### Capacity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| totalThroughputLimit | The total throughput limit imposed on the account. A totalThroughputLimit of 2000 imposes a strict limit of max throughput that can be provisioned on that account to be 2000. A totalThroughputLimit of -1 indicates no limits on provisioning of throughput. | int <br /><br />Constraints:<br />Min value = -1 |

### Components1Jq1T4ISchemasManagedserviceidentityPropertiesUserassignedidentitiesAdditionalproperties

| Name | Description | Value |
| ---- | ----------- | ------------ |

### ConsistencyPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| defaultConsistencyLevel | The default consistency level and configuration settings of the Cosmos DB account. | 'BoundedStaleness'<br />'ConsistentPrefix'<br />'Eventual'<br />'Session'<br />'Strong' (required) |
| maxIntervalInSeconds | When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 5<br />Max value = 86400 |
| maxStalenessPrefix | When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 1 – 2,147,483,647. Required when defaultConsistencyPolicy is set to 'BoundedStaleness'. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### ContinuousModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| continuousModeProperties | Configuration values for continuous mode backup | [ContinuousModeProperties](#continuousmodeproperties-2) |
| type | Describes the mode of backups. | 'Continuous' (required) |

### ContinuousModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| tier | Enum to indicate type of Continuous backup mode | 'Continuous30Days'<br />'Continuous7Days' |

### CorsPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| allowedHeaders | The request headers that the origin domain may specify on the CORS request. | string |
| allowedMethods | The methods (HTTP request verbs) that the origin domain may use for a CORS request. | string |
| allowedOrigins | The origin domains that are permitted to make a request against the service via CORS. | string (required) |
| exposedHeaders | The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer. | string |
| maxAgeInSeconds | The maximum amount time that a browser should cache the preflight OPTIONS request. | int <br /><br />Constraints:<br />Min value = 1<br />Max value = 2147483647 |

### DatabaseAccountCreateUpdatePropertiesOrDatabaseAccountGetProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| analyticalStorageConfiguration | Analytical storage specific properties. | [AnalyticalStorageConfiguration](#analyticalstorageconfiguration-2) |
| apiProperties | API specific properties. Currently, supported only for MongoDB API. | [ApiProperties](#apiproperties-2) |
| backupPolicy | The object representing the policy for taking backups on an account. | [BackupPolicy](#backuppolicy-2) |
| capabilities | List of Cosmos DB capabilities for the account | [Capability](#capability-2)[] |
| capacity | The object that represents all properties related to capacity enforcement on an account. | [Capacity](#capacity-2) |
| connectorOffer | The cassandra connector offer type for the Cosmos DB database C* account. | 'Small' |
| consistencyPolicy | The consistency policy for the Cosmos DB account. | [ConsistencyPolicy](#consistencypolicy-2) |
| cors | The CORS policy for the Cosmos DB database account. | [CorsPolicy](#corspolicy-2)[] |
| createMode | Enum to indicate the mode of account creation. | 'Default'<br />'Restore' |
| customerManagedKeyStatus | Indicates the status of the Customer Managed Key feature on the account. In case there are errors, the property provides troubleshooting guidance. | string |
| databaseAccountOfferType | The offer type for the database | 'Standard' (required) |
| defaultIdentity | The default identity for accessing key vault used in features like customer managed keys. The default identity needs to be explicitly set by the users. It can be "FirstPartyIdentity", "SystemAssignedIdentity" and more. | string |
| disableKeyBasedMetadataWriteAccess | Disable write operations on metadata resources (databases, containers, throughput) via account keys | bool |
| disableLocalAuth | Opt-out of local authentication and ensure only MSI and AAD can be used exclusively for authentication. | bool |
| enableAnalyticalStorage | Flag to indicate whether to enable storage analytics. | bool |
| enableAutomaticFailover | Enables automatic failover of the write region in the rare event that the region is unavailable due to an outage. Automatic failover will result in a new write region for the account and is chosen based on the failover priorities configured for the account. | bool |
| enableBurstCapacity | Flag to indicate enabling/disabling of Burst Capacity feature on the account | bool |
| enableCassandraConnector | Enables the cassandra connector on the Cosmos DB C* account | bool |
| enableFreeTier | Flag to indicate whether Free Tier is enabled. | bool |
| enableMultipleWriteLocations | Enables the account to write in multiple locations | bool |
| enablePartitionMerge | Flag to indicate enabling/disabling of Partition Merge feature on the account | bool |
| ipRules | List of IpRules. | [IpAddressOrRange](#ipaddressorrange-2)[] |
| isVirtualNetworkFilterEnabled | Flag to indicate whether to enable/disable Virtual Network ACL rules. | bool |
| keyVaultKeyUri | The URI of the key vault | string |
| locations | An array that contains the georeplication locations enabled for the Cosmos DB account. | [Location](#location-2)[] (required) |
| minimalTlsVersion | Indicates the minimum allowed Tls version. The default value is Tls 1.2. Cassandra and Mongo APIs only work with Tls 1.2. | 'Tls'<br />'Tls11'<br />'Tls12' |
| networkAclBypass | Indicates what services are allowed to bypass firewall checks. | 'AzureServices'<br />'None' |
| networkAclBypassResourceIds | An array that contains the Resource Ids for Network Acl Bypass for the Cosmos DB account. | string[] |
| publicNetworkAccess | Whether requests from Public Network are allowed | 'Disabled'<br />'Enabled'<br />'SecuredByPerimeter' |
| restoreParameters | Parameters to indicate the information about the restore. | [RestoreParameters](#restoreparameters-2) |
| virtualNetworkRules | List of Virtual Network ACL rules configured for the Cosmos DB account. | [VirtualNetworkRule](#virtualnetworkrule-2)[] |

### DatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| collectionNames | The names of the collections available for restore. | string[] |
| databaseName | The name of the database available for restore. | string |

### GremlinDatabaseRestoreResource

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databaseName | The name of the gremlin database available for restore. | string |
| graphNames | The names of the graphs available for restore. | string[] |

### IpAddressOrRange

| Name | Description | Value |
| ---- | ----------- | ------------ |
| ipAddressOrRange | A single IPv4 address or a single IPv4 address range in CIDR format. Provided IPs must be well-formatted and cannot be contained in one of the following ranges: 10.0.0.0/8, 100.64.0.0/10, 172.16.0.0/12, 192.168.0.0/16, since these are not enforceable by the IP address filter. Example of valid inputs: “23.40.210.245” or “23.40.210.0/8”. | string |

### Location

| Name | Description | Value |
| ---- | ----------- | ------------ |
| failoverPriority | The failover priority of the region. A failover priority of 0 indicates a write region. The maximum value for a failover priority = (total number of regions - 1). Failover priority values must be unique for each of the regions in which the database account exists. | int <br /><br />Constraints:<br />Min value = 0 |
| isZoneRedundant | Flag to indicate whether or not this region is an AvailabilityZone region | bool |
| locationName | The name of the region. | string |

### ManagedServiceIdentity

| Name | Description | Value |
| ---- | ----------- | ------------ |
| type | The type of identity used for the resource. The type 'SystemAssigned,UserAssigned' includes both an implicitly created identity and a set of user assigned identities. The type 'None' will remove any identities from the service. | 'None'<br />'SystemAssigned'<br />'SystemAssigned,UserAssigned'<br />'UserAssigned' |
| userAssignedIdentities | The list of user identities associated with resource. The user identity dictionary key references will be ARM resource ids in the form: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'. | [ManagedServiceIdentityUserAssignedIdentities](#managedserviceidentityuserassignedidentities-2) |

### ManagedServiceIdentityUserAssignedIdentities

| Name | Description | Value |
| ---- | ----------- | ------------ |

### PeriodicModeBackupPolicy

| Name | Description | Value |
| ---- | ----------- | ------------ |
| periodicModeProperties | Configuration values for periodic mode backup | [PeriodicModeProperties](#periodicmodeproperties-2) |
| type | Describes the mode of backups. | 'Periodic' (required) |

### PeriodicModeProperties

| Name | Description | Value |
| ---- | ----------- | ------------ |
| backupIntervalInMinutes | An integer representing the interval in minutes between two backups | int <br /><br />Constraints:<br />Min value = 0 |
| backupRetentionIntervalInHours | An integer representing the time (in hours) that each backup is retained | int <br /><br />Constraints:<br />Min value = 0 |
| backupStorageRedundancy | Enum to indicate type of backup residency | 'Geo'<br />'Local'<br />'Zone' |

### RestoreParameters

| Name | Description | Value |
| ---- | ----------- | ------------ |
| databasesToRestore | List of specific databases available for restore. | [DatabaseRestoreResource](#databaserestoreresource-2)[] |
| gremlinDatabasesToRestore | List of specific gremlin databases available for restore. | [GremlinDatabaseRestoreResource](#gremlindatabaserestoreresource-2)[] |
| restoreMode | Describes the mode of the restore. | 'PointInTime' |
| restoreSource | The id of the restorable database account from which the restore has to be initiated. For example: /subscriptions/{subscriptionId}/providers/Microsoft.DocumentDB/locations/{location}/restorableDatabaseAccounts/{restorableDatabaseAccountName} | string |
| restoreTimestampInUtc | Time to which the account has to be restored (ISO-8601 format). | string |
| tablesToRestore | List of specific tables available for restore. | string[] |

### Tags

| Name | Description | Value |
| ---- | ----------- | ------------ |

### VirtualNetworkRule

| Name | Description | Value |
| ---- | ----------- | ------------ |
| id | Resource ID of a subnet, for example: /subscriptions/{subscriptionId}/resourceGroups/{groupName}/providers/Microsoft.Network/virtualNetworks/{virtualNetworkName}/subnets/{subnetName}. | string |
| ignoreMissingVNetServiceEndpoint | Create firewall rule before the virtual network has vnet service endpoint enabled. | bool |

## Usage Examples
### Terraform Samples

A basic example of deploying CosmosDB (formally DocumentDB) Account.

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

resource "azapi_resource" "databaseAccount" {
  type      = "Microsoft.DocumentDB/databaseAccounts@2021-10-15"
  parent_id = azapi_resource.resourceGroup.id
  name      = var.resource_name
  location  = var.location
  body = {
    kind = "GlobalDocumentDB"
    properties = {
      capabilities = [
      ]
      consistencyPolicy = {
        defaultConsistencyLevel = "BoundedStaleness"
        maxIntervalInSeconds    = 10
        maxStalenessPrefix      = 200
      }
      databaseAccountOfferType           = "Standard"
      defaultIdentity                    = "FirstPartyIdentity"
      disableKeyBasedMetadataWriteAccess = false
      disableLocalAuth                   = false
      enableAnalyticalStorage            = false
      enableAutomaticFailover            = false
      enableFreeTier                     = false
      enableMultipleWriteLocations       = false
      ipRules = [
      ]
      isVirtualNetworkFilterEnabled = false
      locations = [
        {
          failoverPriority = 0
          isZoneRedundant  = false
          locationName     = "West Europe"
        },
      ]
      networkAclBypass = "None"
      networkAclBypassResourceIds = [
      ]
      publicNetworkAccess = "Enabled"
      virtualNetworkRules = [
      ]
    }
  }
  schema_validation_enabled = false
  response_export_values    = ["*"]
}
```

::: zone-end
