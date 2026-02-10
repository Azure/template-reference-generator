param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login for the PostgreSQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string

resource server 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'GP_Gen5_2'
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
  }
  properties: {
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 51200
      backupRetentionDays: 7
    }
    version: '9.5'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.7.29.0/29'
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
    serviceEndpointPolicies: []
    serviceEndpoints: [
      {
        service: 'Microsoft.Sql'
      }
    ]
    addressPrefix: '10.7.29.0/29'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworkRule 'Microsoft.DBforPostgreSQL/servers/virtualNetworkRules@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    ignoreMissingVnetServiceEndpoint: false
    virtualNetworkSubnetId: subnet.id
  }
}
