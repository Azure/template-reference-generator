param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsResolver 'Microsoft.Network/dnsResolvers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    virtualNetwork: {
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
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource inboundEndpoint 'Microsoft.Network/dnsResolvers/inboundEndpoints@2022-07-01' = {
  parent: dnsResolver
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        privateIpAllocationMethod: 'Dynamic'
        subnet: {
          id: subnet.id
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: 'inbounddns'
  properties: {
    addressPrefix: '10.0.0.0/28'
    delegations: [
      {
        name: 'Microsoft.Network.dnsResolvers'
        properties: {
          serviceName: 'Microsoft.Network/dnsResolvers'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
