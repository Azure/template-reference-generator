param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource expressRouteGateway 'Microsoft.Network/expressRouteGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    autoScaleConfiguration: {
      bounds: {
        min: 1
      }
    }
    virtualHub: {}
    allowNonVirtualWanTraffic: false
  }
}

resource virtualHub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressPrefix: '10.0.1.0/24'
    hubRoutingPreference: 'ExpressRoute'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
    virtualWan: {}
  }
}

resource virtualWan 'Microsoft.Network/virtualWans@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    office365LocalBreakoutCategory: 'None'
    type: 'Standard'
    allowBranchToBranchTraffic: true
    disableVpnEncryption: false
  }
}
