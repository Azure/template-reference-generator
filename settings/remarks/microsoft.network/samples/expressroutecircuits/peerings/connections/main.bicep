param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The shared key for the Express Route circuit peering connections')
param expressRouteConnectionSharedKey string

resource expressRouteCircuit2 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'MeteredData'
    name: 'Standard_MeteredData'
    tier: 'Standard'
  }
  properties: {
    authorizationKey: ''
    bandwidthInGbps: 5
    expressRoutePort: {
      id: expressRoutePort2.id
    }
  }
}

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
    peeringType: 'AzurePrivatePeering'
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    sharedKey: '${expressRouteConnectionSharedKey}'
    vlanId: 100
    azureASN: 12076
    peerASN: 100
    primaryPeerAddressPrefix: '192.168.1.0/30'
    state: 'Enabled'
  }
}

resource peering2 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit2
  properties: {
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    sharedKey: '${expressRouteConnectionSharedKey}'
    vlanId: 100
    gatewayManagerEtag: ''
    peerASN: 100
    state: 'Enabled'
    azureASN: 12076
    peeringType: 'AzurePrivatePeering'
  }
}

resource connection 'Microsoft.Network/expressRouteCircuits/peerings/connections@2022-07-01' = {
  name: resourceName
  parent: peering
  properties: {
    addressPrefix: '192.169.8.0/29'
    expressRouteCircuitPeering: {
      id: peering.id
    }
    peerExpressRouteCircuitPeering: {
      id: peering2.id
    }
  }
}

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    peeringLocation: 'Airtel-Chennai2-CLS'
    bandwidthInGbps: 10
    encapsulation: 'Dot1Q'
  }
}

resource expressRoutePort2 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    bandwidthInGbps: 10
    encapsulation: 'Dot1Q'
    peeringLocation: 'CDC-Canberra'
  }
}
