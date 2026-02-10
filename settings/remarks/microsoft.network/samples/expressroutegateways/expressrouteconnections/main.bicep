param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The shared key for the ExpressRoute connection')
param sharedKey string

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
    virtualHub: {}
  }
}

resource expressRouteConnection 'Microsoft.Network/expressRouteGateways/expressRouteConnections@2022-07-01' = {
  name: resourceName
  parent: expressRouteGateway
  properties: {
    enableInternetSecurity: false
    expressRouteCircuitPeering: {}
    expressRouteGatewayBypass: false
    routingConfiguration: {}
    routingWeight: 0
  }
}

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Premium'
    family: 'MeteredData'
    name: 'Premium_MeteredData'
  }
  properties: {
    authorizationKey: ''
    bandwidthInGbps: 5
    expressRoutePort: {
      id: expressRoutePort.id
    }
  }
}

resource peering 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit
  properties: {
    gatewayManagerEtag: ''
    sharedKey: '${sharedKey}'
    azureASN: 12076
    peerASN: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.2.0/30'
    state: 'Enabled'
    vlanId: 100
  }
}

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    bandwidthInGbps: 10
    encapsulation: 'Dot1Q'
    peeringLocation: 'CDC-Canberra'
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
