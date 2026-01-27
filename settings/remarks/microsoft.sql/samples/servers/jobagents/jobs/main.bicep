param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: null
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
  }
}

resource database 'Microsoft.Sql/servers/databases@2023-08-01-preview' = {
  parent: server
  name: '${resourceName}-db'
  location: location
  properties: {
    autoPauseDelay: 0
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    licenseType: ''
    maintenanceConfigurationId: '/subscriptions/subscription().subscriptionId/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    sampleName: ''
    secondaryType: ''
    zoneRedundant: false
  }
  sku: {
    name: 'S1'
  }
}

resource jobAgent 'Microsoft.Sql/servers/jobAgents@2023-08-01-preview' = {
  parent: server
  name: '${resourceName}-job-agent'
  location: location
  properties: {
    databaseId: database.id
  }
  sku: {
    name: 'JA100'
  }
}

resource job 'Microsoft.Sql/servers/jobAgents/jobs@2023-08-01-preview' = {
  parent: jobAgent
  name: '${resourceName}-job'
  properties: {
    description: ''
  }
}
