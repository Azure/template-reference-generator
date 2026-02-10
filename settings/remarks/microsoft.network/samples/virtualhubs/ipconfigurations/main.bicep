param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'RouteServerSubnet'
  parent: virtualNetwork
  properties: {
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.5.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource virtualHub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    hubRoutingPreference: 'ExpressRoute'
    sku: 'Standard'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
  }
}

resource ipConfiguration 'Microsoft.Network/virtualHubs/ipConfigurations@2022-07-01' = {
  name: resourceName
  parent: virtualHub
  properties: {
    privateIPAddress: '10.5.1.18'
    privateIPAllocationMethod: 'Static'
    publicIPAddress: {
      id: publicIPAddress.id
    }
    subnet: {}
  }
}
