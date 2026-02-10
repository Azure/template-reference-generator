param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource eventSource 'Microsoft.TimeSeriesInsights/environments/eventSources@2020-05-15' = {
  name: resourceName
  location: location
  parent: environment
  kind: 'Microsoft.IoTHub'
  properties: {
    sharedAccessKey: iotHub.listKeys().value[0].primaryKey
    timestampPropertyName: ''
    consumerGroupName: 'test'
    eventSourceResourceId: iotHub.id
    iotHubName: iotHub.name
    keyName: 'iothubowner'
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
