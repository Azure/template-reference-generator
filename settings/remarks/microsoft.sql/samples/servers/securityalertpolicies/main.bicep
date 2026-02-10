@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator login name for the SQL server')
param administratorLogin string

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    version: '12.0'
  }
}

resource securityAlertPolicy 'Microsoft.Sql/servers/securityAlertPolicies@2017-03-01-preview' = {
  name: 'Default'
  parent: server
  properties: {
    state: 'Disabled'
  }
}
