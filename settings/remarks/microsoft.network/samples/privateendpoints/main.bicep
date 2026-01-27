param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource loadBalancer 'Microsoft.Network/loadBalancers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    frontendIPConfigurations: [
      {
        name: 'acctest0001'
        properties: {
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    privateLinkServiceConnections: [
      {
        name: privateLinkService.name
        properties: {
          privateLinkServiceId: privateLinkService.id
        }
      }
    ]
    subnet: {
      id: subnet.id
    }
  }
}

resource privateLinkService 'Microsoft.Network/privateLinkServices@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    autoApproval: {
      subscriptions: []
    }
    enableProxyProtocol: false
    fqdns: []
    ipConfigurations: [
      {
        name: 'primaryIpConfiguration-230630033653892379'
        properties: {
          primary: true
          privateIPAddress: ''
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: subnet.id
          }
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
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: resourceName
  properties: {
    addressPrefix: '10.5.4.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
