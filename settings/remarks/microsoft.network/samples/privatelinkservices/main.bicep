param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource loadBalancer 'Microsoft.Network/loadBalancers@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        name: resourceName
        properties: {
          publicIPAddress: {}
        }
      }
    ]
  }
}

resource privateLinkService 'Microsoft.Network/privateLinkServices@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    fqdns: []
    ipConfigurations: [
      {
        name: 'primaryIpConfiguration-230630033653892379'
        properties: {
          primary: true
          privateIPAddress: ''
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
    loadBalancerFrontendIpConfigurations: [
      {
        id: loadBalancer.properties.frontendIPConfigurations[0].id
      }
    ]
    visibility: {
      subscriptions: []
    }
    autoApproval: {
      subscriptions: []
    }
    enableProxyProtocol: false
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Regional'
    name: 'Standard'
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
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.5.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.5.4.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
