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
    isNfsV3Enabled: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
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
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    isLocalUserEnabled: true
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    isSftpEnabled: false
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
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: '${resourceName}vault'
  location: location
  properties: {
    createMode: 'default'
    enableSoftDelete: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    accessPolicies: []
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enabledForDeployment: false
    publicNetworkAccess: 'Enabled'
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
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
  }
}

resource dataStore 'Microsoft.MachineLearningServices/workspaces/dataStores@2024-04-01' = {
  name: replace('${resourceName}_ds', '-', '_')
  parent: workspace
  dependsOn: [
    container
  ]
  properties: {
    accountName: storageAccount.name
    credentials: {
      credentialsType: 'AccountKey'
      secrets: {
        secretsType: 'AccountKey'
        key: base64(storageAccount.listKeys().keys[0].value)
      }
    }
    datastoreType: 'AzureBlob'
    description: ''
    endpoint: 'core.windows.net'
    serviceDataAccessAuthIdentity: 'None'
    tags: null
  }
}
