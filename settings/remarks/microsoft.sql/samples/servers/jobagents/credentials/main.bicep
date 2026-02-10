@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the SQL server credential')
param sqlAdminUsername string
@secure()
@description('The administrator password for the SQL server credential')
param sqlAdminPassword string

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

resource database 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: resourceName
  location: location
  parent: server
  properties: {
    zoneRedundant: false
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    isLedgerOn: false
    minCapacity: 0
    autoPauseDelay: 0
    createMode: 'Default'
    elasticPoolId: ''
    highAvailabilityReplicaCount: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
  }
}
