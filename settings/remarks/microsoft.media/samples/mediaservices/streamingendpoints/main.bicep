param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource mediaService 'Microsoft.Media/mediaServices@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    storageAccounts: [
      {
        type: 'Primary'
      }
    ]
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
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
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    supportsHttpsTrafficOnly: true
  }
}

resource streamingEndpoint 'Microsoft.Media/mediaServices/streamingEndpoints@2022-08-01' = {
  name: resourceName
  location: location
  parent: mediaService
  properties: {
    scaleUnits: 1
  }
  tags: {
    env: 'test'
  }
}
