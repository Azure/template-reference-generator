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
    supportsHttpsTrafficOnly: true
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
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
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

resource streamingPolicy 'Microsoft.Media/mediaServices/streamingPolicies@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    noEncryption: {
      enabledProtocols: {
        dash: true
        download: true
        hls: true
        smoothStreaming: true
      }
    }
  }
}
