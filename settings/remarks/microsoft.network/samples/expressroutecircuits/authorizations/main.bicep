param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    authorizationKey: ''
    serviceProviderProperties: {
      bandwidthInMbps: 50
      peeringLocation: 'Silicon Valley'
      serviceProviderName: 'Equinix'
    }
  }
  sku: {
    family: 'MeteredData'
    name: 'Standard_MeteredData'
    tier: 'Standard'
  }
  tags: {
    Environment: 'production'
    Purpose: 'AcceptanceTests'
  }
}

resource authorization 'Microsoft.Network/expressRouteCircuits/authorizations@2022-07-01' = {
  parent: expressRouteCircuit
  name: resourceName
  properties: {}
}
