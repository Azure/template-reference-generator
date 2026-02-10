param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'MeteredData'
    name: 'Standard_MeteredData'
    tier: 'Standard'
  }
  properties: {
    authorizationKey: ''
    serviceProviderProperties: {
      serviceProviderName: 'Equinix'
      bandwidthInMbps: 50
      peeringLocation: 'Silicon Valley'
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
