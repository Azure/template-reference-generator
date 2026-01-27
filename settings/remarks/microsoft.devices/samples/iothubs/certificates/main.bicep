param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The Base64 encoded certificate content for the IoT Hub')
param certificateContent string

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
    name: 'B1'
  }
}

resource certificate 'Microsoft.Devices/IotHubs/certificates@2022-04-30-preview' = {
  parent: iothub
  name: resourceName
  properties: {
    certificate: null
    isVerified: false
  }
}
