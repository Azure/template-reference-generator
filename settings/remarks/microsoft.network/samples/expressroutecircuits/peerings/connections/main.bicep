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
    peerASN: 100
    sharedKey: '${expressRouteConnectionSharedKey}'
    state: 'Enabled'
    vlanId: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    azureASN: 12076
  }
}

resource peering2 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit2
  properties: {
    gatewayManagerEtag: ''
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    vlanId: 100
    azureASN: 12076
    peerASN: 100
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    sharedKey: '${expressRouteConnectionSharedKey}'
    state: 'Enabled'
  }
}

resource connection 'Microsoft.Network/expressRouteCircuits/peerings/connections@2022-07-01' = {
  name: resourceName
  parent: peering
  properties: {
    peerExpressRouteCircuitPeering: {
      id: peering2.id
    }
    addressPrefix: '192.169.8.0/29'
    expressRouteCircuitPeering: {
      id: peering.id
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
    encapsulation: 'Dot1Q'
    peeringLocation: 'CDC-Canberra'
    bandwidthInGbps: 10
  }
}
