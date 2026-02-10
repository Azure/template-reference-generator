param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The shared key for the Express Route circuit peering')
param expressRouteSharedKey string

resource expressRoutePort 'Microsoft.Network/ExpressRoutePorts@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    encapsulation: 'Dot1Q'
    peeringLocation: 'CDC-Canberra'
    bandwidthInGbps: 10
  }
}

resource expressRouteCircuit 'Microsoft.Network/expressRouteCircuits@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    family: 'MeteredData'
    name: 'Premium_MeteredData'
    tier: 'Premium'
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
    secondaryPeerAddressPrefix: '192.168.2.0/30'
    sharedKey: '${expressRouteSharedKey}'
    state: 'Enabled'
    azureASN: 12076
    gatewayManagerEtag: ''
    peerASN: 100
    primaryPeerAddressPrefix: '192.168.1.0/30'
    vlanId: 100
    peeringType: 'AzurePrivatePeering'
  }
}
