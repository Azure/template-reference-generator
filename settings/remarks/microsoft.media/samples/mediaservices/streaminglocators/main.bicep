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
    isNfsV3Enabled: false
    isSftpEnabled: false
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
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
  }
}

resource asset 'Microsoft.Media/mediaServices/assets@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: ''
  }
}

resource streamingLocator 'Microsoft.Media/mediaServices/streamingLocators@2022-08-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    assetName: asset.name
    streamingPolicyName: 'Predefined_ClearStreamingOnly'
  }
}
