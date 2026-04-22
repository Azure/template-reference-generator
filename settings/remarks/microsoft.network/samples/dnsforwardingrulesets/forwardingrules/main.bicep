param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dnsResolver 'Microsoft.Network/dnsResolvers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    virtualNetwork: {}
  }
}

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

resource dnsForwardingRuleset 'Microsoft.Network/dnsForwardingRulesets@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    dnsResolverOutboundEndpoints: [
      {}
    ]
  }
}

resource forwardingRule 'Microsoft.Network/dnsForwardingRulesets/forwardingRules@2022-07-01' = {
  name: resourceName
  parent: dnsForwardingRuleset
  properties: {
    domainName: 'onprem.local.'
    forwardingRuleState: 'Enabled'
    metadata: null
    targetDnsServers: [
      {
        ipAddress: '10.10.0.1'
        port: 53
      }
    ]
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
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.0.64/28'
    delegations: [
      {
        name: 'Microsoft.Network.dnsResolvers'
        properties: {
          serviceName: 'Microsoft.Network/dnsResolvers'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
  }
}
