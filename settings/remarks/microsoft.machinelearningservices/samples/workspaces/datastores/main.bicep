param location string = 'westus'
param resourceName string = 'acctest0001'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${toLower(substring(resourceName, 0, 16))}acc'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
    isLocalUserEnabled: true
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowSharedKeyAccess: true
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
    }
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    isSftpEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}vault'
  location: location
  properties: {
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant()
    createMode: 'default'
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: true
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: '${resourceName}-mlw'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  kind: 'Default'
  properties: {
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
    applicationInsights: component.id
    keyVault: vault.id
  }
}

resource storageaccountBlobservices 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: 'datacontainer'
  parent: storageaccountBlobservices
  properties: {
    publicAccess: 'None'
  }
}

resource dataStore 'Microsoft.MachineLearningServices/workspaces/dataStores@2024-04-01' = {
  name: replace('${resourceName}_ds', '-', '_')
  parent: workspace
  dependsOn: [
    container
  ]
  properties: {
    serviceDataAccessAuthIdentity: 'None'
    tags: null
    accountName: storageAccount.name
    credentials: {
      credentialsType: 'AccountKey'
      secrets: {
        key: base64(storageAccount.listKeys().keys[0].value)
        secretsType: 'AccountKey'
      }
    }
    datastoreType: 'AzureBlob'
    description: ''
    endpoint: 'core.windows.net'
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: '${resourceName}-ai'
  location: location
  kind: 'web'
  properties: {
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableLocalAuth: false
  }
}
