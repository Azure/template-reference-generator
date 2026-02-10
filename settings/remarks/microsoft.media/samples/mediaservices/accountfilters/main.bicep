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
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    isHnsEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    allowCrossTenantReplication: true
  }
}

resource accountFilter 'Microsoft.Media/mediaServices/accountFilters@2022-08-01' = {
  name: 'Filter-1'
  parent: mediaService
  properties: {
    tracks: []
  }
}
