param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource dnsResolver 'Microsoft.Network/dnsResolvers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    virtualNetwork: {}
  }
}

resource outboundEndpoint 'Microsoft.Network/dnsResolvers/outboundEndpoints@2022-07-01' = {
  name: resourceName
  location: location
  parent: dnsResolver
  properties: {
    subnet: {}
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'outbounddns'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.64/28'
    delegations: [
      {
        properties: {
          serviceName: 'Microsoft.Network/dnsResolvers'
        }
        name: 'Microsoft.Network.dnsResolvers'
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource dnsForwardingRuleset 'Microsoft.Network/dnsForwardingRulesets@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    dnsResolverOutboundEndpoints: [
      {}
    ]
  }
}
