param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'B1'
  }
  properties: {
    cloudToDevice: {}
    enableFileUploadNotifications: false
    messagingEndpoints: {}
    routing: {
      fallbackRoute: {
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: true
        source: 'DeviceMessages'
      }
    }
    storageEndpoints: {}
  }
  tags: {
    purpose: 'testing'
  }
}

resource environment 'Microsoft.TimeSeriesInsights/environments@2020-05-15' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'L1'
  }
  kind: 'Gen2'
  properties: {
    storageConfiguration: {
      managementKey: storageAccount.listKeys().keys[0].value
    }
    timeSeriesIdProperties: [
      {
        name: 'id'
        type: 'String'
      }
    ]
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
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
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
  }
}

resource eventSource 'Microsoft.TimeSeriesInsights/environments/eventSources@2020-05-15' = {
  name: resourceName
  location: location
  parent: environment
  kind: 'Microsoft.IoTHub'
  properties: {
    eventSourceResourceId: iotHub.id
    iotHubName: iotHub.name
    keyName: 'iothubowner'
    sharedAccessKey: iotHub.listKeys().value[0].primaryKey
    timestampPropertyName: ''
    consumerGroupName: 'test'
  }
}
