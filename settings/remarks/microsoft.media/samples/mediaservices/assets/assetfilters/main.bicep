param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource mediaService 'Microsoft.Media/mediaServices@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    storageAccounts: [
      {
        type: 'Primary'
      }
    ]
    publicNetworkAccess: 'Enabled'
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
    defaultToOAuthAuthentication: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
    accessTier: 'Hot'
    allowSharedKeyAccess: true
  }
}

resource asset 'Microsoft.Media/mediaServices/assets@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: ''
  }
}

resource assetFilter 'Microsoft.Media/mediaServices/assets/assetFilters@2022-08-01' = {
  name: resourceName
  parent: asset
  properties: {
    firstQuality: {
      bitrate: 0
    }
  }
}
