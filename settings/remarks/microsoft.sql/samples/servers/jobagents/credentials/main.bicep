param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the SQL server credential')
param sqlAdminUsername string
@secure()
@description('The administrator password for the SQL server credential')
param sqlAdminPassword string
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: resourceName
  location: location
  properties: {
    version: '12.0'
    administratorLogin: '4dministr4t0r'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }
}

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    minCapacity: 0
    requestedBackupStorageRedundancy: 'Geo'
    zoneRedundant: false
    autoPauseDelay: 0
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    readScale: 'Disabled'
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    elasticPoolId: ''
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

resource credential 'Microsoft.Sql/servers/jobAgents/credentials@2020-11-01-preview' = {
  name: resourceName
  parent: jobAgent
  properties: {
    password: '${sqlAdminPassword}'
    username: '${sqlAdminUsername}'
  }
}
