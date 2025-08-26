param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource dnsAlias 'Microsoft.Sql/servers/dnsAliases@2020-11-01-preview' = {
  parent: server
  name: resource_name
}

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  location: location
  name: resource_name
  properties: {
    administratorLogin: 'umtacc'
    administratorLoginPassword: 'random81jdpwd_$#fs'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

