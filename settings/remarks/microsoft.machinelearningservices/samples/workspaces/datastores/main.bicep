param resourceName string = 'acctest0001'
param location string = 'westus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${toLower(substring(resourceName, 0, 16))}acc'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: false
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    networkAcls: {
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
    }
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    isLocalUserEnabled: true
    accessTier: 'Hot'
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    allowSharedKeyAccess: true
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

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: '${resourceName}-ai'
  location: location
  kind: 'web'
  properties: {
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableLocalAuth: false
    Application_Type: 'web'
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}vault'
  location: location
  properties: {
    createMode: 'default'
    enableRbacAuthorization: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: []
    enablePurgeProtection: true
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
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
    storageAccount: storageAccount.id
    v1LegacyMode: false
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Enabled'
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
