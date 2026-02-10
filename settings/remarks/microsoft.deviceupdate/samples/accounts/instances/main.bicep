param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource iotHub 'Microsoft.Devices/IotHubs@2022-04-30-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'S1'
  }
  properties: {
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
    cloudToDevice: {}
    enableFileUploadNotifications: false
  }
}
