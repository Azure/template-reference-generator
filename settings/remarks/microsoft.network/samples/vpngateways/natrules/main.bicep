param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vpnGateway 'Microsoft.Network/vpnGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableBgpRouteTranslationForNat: false
    isRoutingPreferenceInternet: false
    virtualHub: {
      id: virtualHub.id
    }
    vpnGatewayScaleUnit: 1
  }
}

resource natRule 'Microsoft.Network/vpnGateways/natRules@2022-07-01' = {
  name: resourceName
  parent: vpnGateway
  properties: {
    externalMappings: [
      {
        addressSpace: '192.168.21.0/26'
      }
    ]
    internalMappings: [
      {
        addressSpace: '10.4.0.0/26'
      }
    ]
    mode: 'EgressSnat'
    type: 'Static'
  }
}

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
    office365LocalBreakoutCategory: 'None'
    type: 'Standard'
    allowBranchToBranchTraffic: true
    disableVpnEncryption: false
  }
}
