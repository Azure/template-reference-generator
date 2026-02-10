param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The Base64 encoded certificate content for the IoT Hub')
param certificateContent string

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
        endpointNames: [
          'events'
        ]
        isEnabled: true
        source: 'DeviceMessages'
        condition: 'true'
      }
    }
  }
}

resource certificate 'Microsoft.Devices/IotHubs/certificates@2022-04-30-preview' = {
  name: resourceName
  parent: iotHub
  properties: {
    certificate: '${certificateContent}'
    isVerified: false
  }
}
