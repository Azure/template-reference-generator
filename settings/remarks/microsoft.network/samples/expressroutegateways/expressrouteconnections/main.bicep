param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The shared key for the ExpressRoute connection')
param sharedKey string

resource expressrouteport 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    bandwidthInGbps: 10
    encapsulation: 'Dot1Q'
    peeringLocation: 'CDC-Canberra'
  }
}

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    authorizationKey: ''
    bandwidthInGbps: 5
    expressRoutePort: {
      id: expressrouteport.id
    }
  }
  sku: {
    family: 'MeteredData'
    name: 'Premium_MeteredData'
    tier: 'Premium'
  }
}

resource expressRouteGateway 'Microsoft.Network/expressRouteGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    allowNonVirtualWanTraffic: false
    autoScaleConfiguration: {
      bounds: {
        min: 1
      }
    }
    virtualHub: {
      id: virtualHub.id
    }
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
    virtualWan: {
      id: virtualWan.id
    }
  }
}

resource virtualWan 'Microsoft.Network/virtualWans@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    allowBranchToBranchTraffic: true
    disableVpnEncryption: false
    office365LocalBreakoutCategory: 'None'
    type: 'Standard'
  }
}

resource expressRouteConnection 'Microsoft.Network/expressRouteGateways/expressRouteConnections@2022-07-01' = {
  parent: expressRouteGateway
  name: resourceName
  properties: {
    enableInternetSecurity: false
    expressRouteCircuitPeering: {
      id: peering.id
    }
    expressRouteGatewayBypass: false
    routingConfiguration: {}
    routingWeight: 0
  }
}

resource peering 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  parent: expressRouteCircuit
  name: 'AzurePrivatePeering'
  properties: {
    azureASN: 12076
    gatewayManagerEtag: ''
    peerASN: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.2.0/30'
    sharedKey: null
    state: 'Enabled'
    vlanId: 100
  }
}
