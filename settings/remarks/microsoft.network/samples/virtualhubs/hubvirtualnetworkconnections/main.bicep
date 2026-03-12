param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource virtualHub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    hubRoutingPreference: 'ExpressRoute'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
    virtualWan: {}
    addressPrefix: '10.0.2.0/24'
  }
}

resource hubVirtualNetworkConnection 'Microsoft.Network/virtualHubs/hubVirtualNetworkConnections@2022-07-01' = {
  name: resourceName
  parent: virtualHub
  properties: {
    enableInternetSecurity: false
    remoteVirtualNetwork: {
      id: virtualNetwork.id
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.5.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
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
