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

resource service 'Microsoft.DataMigration/services@2018-04-19' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_1vCores'
  }
  kind: 'Cloud'
  properties: {}
}

resource project 'Microsoft.DataMigration/services/projects@2018-04-19' = {
  name: resourceName
  location: location
  parent: service
  properties: {
    sourcePlatform: 'SQL'
    targetPlatform: 'SQLDB'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
