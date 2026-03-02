param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iotSecuritySolution 'Microsoft.Security/iotSecuritySolutions@2019-08-01' = {
  name: resourceName
  location: location
  properties: {
    displayName: 'Iot Security Solution'
    iotHubs: [
      iotHub.id
    ]
    status: 'Enabled'
    unmaskedIpLoggingStatus: 'Disabled'
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
}
