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
    isHnsEnabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
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
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
  }
}

resource transform 'Microsoft.Media/mediaServices/transforms@2022-07-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: ''
    outputs: [
      {
        preset: {
          '@odata.type': '#Microsoft.Media.BuiltInStandardEncoderPreset'
          presetName: 'AACGoodQualityAudio'
        }
        relativePriority: 'Normal'
        onError: 'ContinueJob'
      }
    ]
  }
}
