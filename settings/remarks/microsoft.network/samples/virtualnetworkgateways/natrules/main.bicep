param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualNetworkGateway 'Microsoft.Network/virtualNetworkGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    activeActive: false
    enableBgp: false
    enablePrivateIpAddress: false
    gatewayType: 'Vpn'
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
      name: 'Basic'
      tier: 'Basic'
    }
    vpnType: 'RouteBased'
  }
}

resource natRule 'Microsoft.Network/virtualNetworkGateways/natRules@2022-07-01' = {
  name: resourceName
  parent: virtualNetworkGateway
  properties: {
    externalMappings: [
      {
        addressSpace: '10.1.0.0/26'
      }
    ]
    internalMappings: [
      {
        addressSpace: '10.3.0.0/26'
      }
    ]
    mode: 'EgressSnat'
    type: 'Static'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'GatewaySubnet'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.1.0/24'
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
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Dynamic'
  }
}
