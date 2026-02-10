param location string = 'westeurope'
@secure()
@description('The shared key for the ExpressRoute connection')
param sharedKey string
param resourceName string = 'acctest0001'

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
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
    virtualWan: {}
    addressPrefix: '10.0.1.0/24'
    hubRoutingPreference: 'ExpressRoute'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
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

resource peering 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit
  properties: {
    azureASN: 12076
    gatewayManagerEtag: ''
    peerASN: 100
    secondaryPeerAddressPrefix: '192.168.2.0/30'
    sharedKey: '${sharedKey}'
    state: 'Enabled'
    vlanId: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
  }
}
