param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the SQL server')
param sqlAdministratorPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    administratorLogin: '4dministr4t0r'
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: server
  name: resourceName
  location: location
  properties: {
    autoPauseDelay: 0
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    maintenanceConfigurationId: resourceId('Microsoft.Maintenance/publicMaintenanceConfigurations', 'SQL_Default')
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    zoneRedundant: false
  }
}

resource jobAgent 'Microsoft.Sql/servers/jobAgents@2020-11-01-preview' = {
  parent: server
  name: resourceName
  location: location
  properties: {
    databaseId: database.id
  }
}
