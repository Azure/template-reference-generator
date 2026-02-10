param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    family: 'MeteredData'
    name: 'Standard_MeteredData'
  }
  properties: {
    authorizationKey: ''
    serviceProviderProperties: {
      bandwidthInMbps: 50
      peeringLocation: 'Silicon Valley'
      serviceProviderName: 'Equinix'
    }
  }
  tags: {
    Environment: 'production'
    Purpose: 'AcceptanceTests'
  }
}

resource authorization 'Microsoft.Network/expressRouteCircuits/authorizations@2022-07-01' = {
  name: resourceName
  parent: expressRouteCircuit
  properties: {}
}
