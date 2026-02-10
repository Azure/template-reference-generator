param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
  }
}

resource encryptionProtector 'Microsoft.Sql/servers/encryptionProtector@2023-08-01-preview' = {
  name: 'current'
  parent: server
  properties: {
    autoRotationEnabled: false
    serverKeyName: ''
    serverKeyType: 'ServiceManaged'
  }
}
