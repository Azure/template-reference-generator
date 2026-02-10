param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource searchService 'Microsoft.Search/searchServices@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    disableLocalAuth: false
    encryptionWithCmk: {
      enforcement: 'Disabled'
    }
    hostingMode: 'default'
    partitionCount: 1
    replicaCount: 1
    networkRuleSet: {
      ipRules: []
    }
    publicNetworkAccess: 'Enabled'
    authOptions: {
      apiKeyOnly: {}
    }
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
    accessTier: 'Hot'
    allowCrossTenantReplication: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
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
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
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
