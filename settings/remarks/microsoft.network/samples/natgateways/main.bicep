param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource natGateway 'Microsoft.Network/natGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    idleTimeoutInMinutes: 10
  }
  sku: {
    name: 'Standard'
  }
}
