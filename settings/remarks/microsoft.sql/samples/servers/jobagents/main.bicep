param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL server')
param sqlAdministratorPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLoginPassword: '${sqlAdministratorPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '4dministr4t0r'
  }
}

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    isLedgerOn: false
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    zoneRedundant: false
    autoPauseDelay: 0
    elasticPoolId: ''
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    highAvailabilityReplicaCount: 0
  }
}

resource jobAgent 'Microsoft.Sql/servers/jobAgents@2020-11-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    databaseId: database.id
  }
}
