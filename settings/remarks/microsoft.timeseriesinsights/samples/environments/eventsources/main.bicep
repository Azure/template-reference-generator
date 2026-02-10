param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource environment 'Microsoft.TimeSeriesInsights/environments@2020-05-15' = {
  name: resourceName
  location: location
  sku: {
    name: 'L1'
    capacity: 1
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

resource eventSource 'Microsoft.TimeSeriesInsights/environments/eventSources@2020-05-15' = {
  name: resourceName
  location: location
  parent: environment
  kind: 'Microsoft.IoTHub'
  properties: {
    timestampPropertyName: ''
    consumerGroupName: 'test'
    eventSourceResourceId: iotHub.id
    iotHubName: iotHub.name
    keyName: 'iothubowner'
    sharedAccessKey: iotHub.listKeys().value[0].primaryKey
  }
}

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'B1'
  }
  properties: {
    storageEndpoints: {}
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
  }
  tags: {
    purpose: 'testing'
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
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
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
    networkAcls: {
      defaultAction: 'Allow'
    }
    allowCrossTenantReplication: true
    isHnsEnabled: false
  }
}
