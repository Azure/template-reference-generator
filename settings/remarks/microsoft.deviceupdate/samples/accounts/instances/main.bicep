param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iothub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
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
  sku: {
    capacity: 1
    name: 'S1'
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
  parent: account
  name: resourceName
  location: location
  properties: {
    accountName: account.name
    enableDiagnostics: false
    iotHubs: [
      {
        resourceId: iothub.id
      }
    ]
  }
}
