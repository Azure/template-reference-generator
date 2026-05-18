param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The shared key for the Express Route circuit peering connections')
param expressRouteConnectionSharedKey string

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    bandwidthInGbps: 10
    encapsulation: 'Dot1Q'
    peeringLocation: 'Airtel-Chennai2-CLS'
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

resource peering 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit
  properties: {
    azureASN: 12076
    gatewayManagerEtag: ''
    peerASN: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    sharedKey: expressRouteConnectionSharedKey
    state: 'Enabled'
    vlanId: 100
  }
}

resource peering2 'Microsoft.Network/expressRouteCircuits/peerings@2022-07-01' = {
  name: 'AzurePrivatePeering'
  parent: expressRouteCircuit2
  properties: {
    azureASN: 12076
    gatewayManagerEtag: ''
    peerASN: 100
    peeringType: 'AzurePrivatePeering'
    primaryPeerAddressPrefix: '192.168.1.0/30'
    secondaryPeerAddressPrefix: '192.168.1.0/30'
    sharedKey: expressRouteConnectionSharedKey
    state: 'Enabled'
    vlanId: 100
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
