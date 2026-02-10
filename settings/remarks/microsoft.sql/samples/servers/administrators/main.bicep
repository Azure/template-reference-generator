param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

param clientId string

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    version: '12.0'
    administratorLogin: 'mradministrator'
  }
}

resource administrator 'Microsoft.Sql/servers/administrators@2020-11-01-preview' = {
  name: 'ActiveDirectory'
  parent: server
  properties: {
    administratorType: 'ActiveDirectory'
    login: 'sqladmin'
    sid: clientId
    tenantId: tenant().tenantId
  }
}
