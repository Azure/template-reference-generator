param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource natGateway 'Microsoft.Network/natGateways@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    idleTimeoutInMinutes: 10
  }
}
