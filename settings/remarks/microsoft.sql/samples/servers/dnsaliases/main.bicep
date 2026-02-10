param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the SQL server')
param administratorLogin string
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
  }
}

resource dnsAlias 'Microsoft.Sql/servers/dnsAliases@2020-11-01-preview' = {
  name: resourceName
  parent: server
}
