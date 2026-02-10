param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the MySQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the MySQL server')
param administratorLoginPassword string

resource server 'Microsoft.DBforMySQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'GeneralPurpose'
    capacity: 2
    family: 'Gen5'
    name: 'GP_Gen5_2'
  }
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 51200
    }
    version: '5.7'
    administratorLogin: '${administratorLogin}'
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
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: [
      {
        service: 'Microsoft.Sql'
      }
    ]
    addressPrefix: '10.7.29.0/29'
  }
}

resource virtualNetworkRule 'Microsoft.DBforMySQL/servers/virtualNetworkRules@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    ignoreMissingVnetServiceEndpoint: false
    virtualNetworkSubnetId: subnet.id
  }
}
