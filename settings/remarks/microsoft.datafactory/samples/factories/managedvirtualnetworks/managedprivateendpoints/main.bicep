param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    globalParameters: {}
    publicNetworkAccess: 'Enabled'
  }
}

resource managedVirtualNetwork 'Microsoft.DataFactory/factories/managedVirtualNetworks@2018-06-01' = {
  name: 'default'
  parent: factory
  properties: {}
}

resource managedPrivateEndpoint 'Microsoft.DataFactory/factories/managedVirtualNetworks/managedPrivateEndpoints@2018-06-01' = {
  name: resourceName
  parent: managedVirtualNetwork
  properties: {
    groupId: 'blob'
    privateLinkResourceId: storageAccount.id
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'BlobStorage'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}
