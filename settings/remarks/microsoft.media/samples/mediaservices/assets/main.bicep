param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    allowBlobPublicAccess: true
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
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}

resource asset 'Microsoft.Media/mediaServices/assets@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: ''
  }
}
