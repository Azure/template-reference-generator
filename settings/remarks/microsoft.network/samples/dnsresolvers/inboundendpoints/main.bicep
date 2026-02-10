param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsResolver 'Microsoft.Network/dnsResolvers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    virtualNetwork: {}
  }
}

resource inboundEndpoint 'Microsoft.Network/dnsResolvers/inboundEndpoints@2022-07-01' = {
  name: resourceName
  location: location
  parent: dnsResolver
  properties: {
    ipConfigurations: [
      {
        privateIpAllocationMethod: 'Dynamic'
        subnet: {}
      }
    ]
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
  name: 'inbounddns'
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.0.0/28'
    delegations: [
      {
        name: 'Microsoft.Network.dnsResolvers'
        properties: {
          serviceName: 'Microsoft.Network/dnsResolvers'
        }
      }
    ]
  }
}
