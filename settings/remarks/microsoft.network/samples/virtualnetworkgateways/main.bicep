param resourceName string = 'acctest0001'
param location string = 'centralus'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.6.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'GatewaySubnet'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.6.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
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
    publicIPAllocationMethod: 'Static'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
  }
}

resource virtualNetworkGateway 'Microsoft.Network/virtualNetworkGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enablePrivateIpAddress: false
    gatewayType: 'ExpressRoute'
    ipConfigurations: [
      {
        name: 'vnetGatewayConfig'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {}
        }
      }
    ]
    sku: {
      name: 'Standard'
      tier: 'Standard'
    }
    vpnType: 'RouteBased'
    activeActive: false
    enableBgp: false
  }
}
