param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource service 'Microsoft.DataMigration/services@2018-04-19' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_1vCores'
  }
  kind: 'Cloud'
  properties: {}
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
  name: resourceName
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.1.0/24'
    delegations: []
  }
}
