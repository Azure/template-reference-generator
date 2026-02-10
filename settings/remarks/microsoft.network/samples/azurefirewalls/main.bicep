param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource azureFirewall 'Microsoft.Network/azureFirewalls@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    threatIntelMode: 'Deny'
    additionalProperties: {}
    ipConfigurations: [
      {
        name: 'configuration'
        properties: {
          publicIPAddress: {}
          subnet: {}
        }
      }
    ]
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
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
  name: 'AzureFirewallSubnet'
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
  }
}
