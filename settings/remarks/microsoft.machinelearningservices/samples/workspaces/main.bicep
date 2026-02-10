param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
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
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isSftpEnabled: false
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    createMode: 'default'
    enablePurgeProtection: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    accessPolicies: [
      {
        objectId: '45a2d1ea-488a-44b0-bb2e-3cd8e485ebef'
        permissions: {
          certificates: [
            'all'
          ]
          keys: [
            'all'
          ]
          secrets: [
            'all'
          ]
          storage: []
        }
        tenantId: tenant().tenantId
      }
    ]
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2022-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Disabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
  }
}
