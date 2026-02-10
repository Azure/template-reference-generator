param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    encryption: {
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
      keySource: 'Microsoft.Storage'
    }
    isNfsV3Enabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
  }
}

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

resource accountFilter 'Microsoft.Media/mediaServices/accountFilters@2022-08-01' = {
  name: 'Filter-1'
  parent: mediaService
  properties: {
    tracks: []
  }
}
