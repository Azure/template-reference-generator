param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  properties: {
    cloudToDevice: {}
    enableFileUploadNotifications: false
    messagingEndpoints: {}
    routing: {
      fallbackRoute: {
        isEnabled: true
        source: 'DeviceMessages'
        condition: 'true'
        endpointNames: [
          'events'
        ]
      }
    }
    storageEndpoints: {}
  }
}

resource account 'Microsoft.DeviceUpdate/accounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sku: 'Standard'
  }
}

resource instance 'Microsoft.DeviceUpdate/accounts/instances@2022-10-01' = {
  name: resourceName
  location: location
  parent: account
  properties: {
    accountName: account.name
    enableDiagnostics: false
    iotHubs: [
      {
        resourceId: iotHub.id
      }
    ]
  }
}
