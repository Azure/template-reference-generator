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
    administratorLogin: null
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource connectionPolicy 'Microsoft.Sql/servers/connectionPolicies@2014-04-01' = {
  parent: server
  name: 'default'
  properties: {
    connectionType: 'Default'
  }
}
