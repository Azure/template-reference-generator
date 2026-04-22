param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
  name: 'outbounddns'
  parent: virtualNetwork
  properties: {
    serviceEndpoints: []
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

resource virtualNetworkLink 'Microsoft.Network/dnsForwardingRulesets/virtualNetworkLinks@2022-07-01' = {
  name: resourceName
  parent: dnsForwardingRuleset
  properties: {
    metadata: null
    virtualNetwork: {
      id: virtualNetwork.id
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
