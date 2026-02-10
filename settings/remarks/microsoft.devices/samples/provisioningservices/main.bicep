param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource provisioningService 'Microsoft.Devices/provisioningServices@2022-02-05' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'S1'
  }
  properties: {
    iotHubs: []
    publicNetworkAccess: 'Enabled'
    allocationPolicy: 'Hashed'
    enableDataResidency: false
  }
}
