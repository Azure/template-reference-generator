param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('Admin password for the database')
param adminPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: 'msincredible'
    administratorLoginPassword: '${adminPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Enabled'
    version: '12.0'
  }
}

resource outboundFirewallRule 'Microsoft.Sql/servers/outboundFirewallRules@2021-02-01-preview' = {
  name: 'sql230630033612934212.database.windows.net'
  parent: server
  properties: {}
}
