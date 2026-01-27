param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2015-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: 'mradministrator'
    administratorLoginPassword: null
    version: '12.0'
  }
}

resource administrator 'Microsoft.Sql/servers/administrators@2020-11-01-preview' = {
  parent: server
  name: 'ActiveDirectory'
  properties: {
    administratorType: 'ActiveDirectory'
    login: 'sqladmin'
    sid: deployer().objectId
    tenantId: deployer().tenantId
  }
}
