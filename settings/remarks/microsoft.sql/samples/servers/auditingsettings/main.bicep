param resourceName string = 'acctest0001'
param location string = 'eastus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: 'mradministrator'
    administratorLoginPassword: '${administratorLoginPassword}'
  }
}

resource auditingSettings 'Microsoft.Sql/servers/auditingSettings@2022-05-01-preview' = {
  name: 'default'
  parent: server
  properties: {
    auditActionsAndGroups: [
      'FAILED_DATABASE_AUTHENTICATION_GROUP'
      'SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP'
    ]
    isAzureMonitorTargetEnabled: true
    state: 'Enabled'
  }
}
