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
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
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

resource transform 'Microsoft.Media/mediaServices/transforms@2022-07-01' = {
  name: resourceName
  parent: mediaService
  properties: {
    description: ''
    outputs: [
      {
        onError: 'ContinueJob'
        preset: {
          '@odata.type': '#Microsoft.Media.BuiltInStandardEncoderPreset'
          presetName: 'AACGoodQualityAudio'
        }
        relativePriority: 'Normal'
      }
    ]
  }
}
