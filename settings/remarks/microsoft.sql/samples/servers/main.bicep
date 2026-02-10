param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL server')
param sqlAdministratorPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${sqlAdministratorPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }
}
