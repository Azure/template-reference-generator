param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: 'msincredible'
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource firewallRule 'Microsoft.Sql/servers/firewallRules@2020-11-01-preview' = {
  parent: server
  name: resourceName
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}
