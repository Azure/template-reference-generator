param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '4dm1n157r470r'
  }
}

resource database 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  name: '${resourceName}-db'
  location: location
  parent: server
  sku: {
    name: 'S1'
  }
  properties: {
    isLedgerOn: false
    sampleName: ''
    licenseType: ''
    maintenanceConfigurationId: '/subscriptions/${subscription()}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    minCapacity: 0
    readScale: 'Disabled'
    secondaryType: ''
    zoneRedundant: false
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    highAvailabilityReplicaCount: 0
    requestedBackupStorageRedundancy: 'Geo'
    autoPauseDelay: 0
    createMode: 'Default'
  }
}

resource jobAgent 'Microsoft.Sql/servers/jobAgents@2023-08-01-preview' = {
  name: '${resourceName}-job-agent'
  location: location
  parent: server
  sku: {
    name: 'JA100'
  }
  properties: {
    databaseId: database.id
  }
}

resource job 'Microsoft.Sql/servers/jobAgents/jobs@2023-08-01-preview' = {
  name: '${resourceName}-job'
  parent: jobAgent
  properties: {
    description: ''
  }
}
