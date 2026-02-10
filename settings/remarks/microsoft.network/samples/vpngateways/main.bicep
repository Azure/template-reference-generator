param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource virtualHub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressPrefix: '10.0.0.0/24'
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
    disableVpnEncryption: false
    office365LocalBreakoutCategory: 'None'
    type: 'Standard'
    allowBranchToBranchTraffic: true
  }
}

resource vpnGateway 'Microsoft.Network/vpnGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    vpnGatewayScaleUnit: 1
    enableBgpRouteTranslationForNat: false
    isRoutingPreferenceInternet: false
    virtualHub: {
      id: virtualHub.id
    }
  }
}
