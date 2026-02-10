param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Regional'
    name: 'Basic'
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
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
          publicIPAddress: {
            id: publicIPAddress.id
          }
          subnet: {}
          privateIPAllocationMethod: 'Dynamic'
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
    type: 'Static'
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
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'GatewaySubnet'
  parent: virtualNetwork
  properties: {
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
