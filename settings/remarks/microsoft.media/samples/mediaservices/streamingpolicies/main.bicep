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
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
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
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
  }
}

resource streamingPolicy 'Microsoft.Media/mediaServices/streamingPolicies@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    noEncryption: {
      enabledProtocols: {
        smoothStreaming: true
        dash: true
        download: true
        hls: true
      }
    }
  }
}
