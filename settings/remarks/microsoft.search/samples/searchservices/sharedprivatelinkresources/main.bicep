param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource searchService 'Microsoft.Search/searchServices@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    partitionCount: 1
    authOptions: {
      apiKeyOnly: {}
    }
    disableLocalAuth: false
    networkRuleSet: {
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
    replicaCount: 1
    encryptionWithCmk: {
      enforcement: 'Disabled'
    }
    hostingMode: 'default'
  }
  tags: {
    environment: 'staging'
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
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
  }
}

resource sharedPrivateLinkResource 'Microsoft.Search/searchServices/sharedPrivateLinkResources@2022-09-01' = {
  name: resourceName
  parent: searchService
  properties: {
    groupId: 'blob'
    privateLinkResourceId: storageAccount.id
    requestMessage: 'please approve'
  }
}
