param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
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
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    minCapacity: 0
    readScale: 'Disabled'
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    licenseType: ''
    maintenanceConfigurationId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    sampleName: ''
    createMode: 'Default'
    requestedBackupStorageRedundancy: 'Geo'
    zoneRedundant: false
    secondaryType: ''
    autoPauseDelay: 0
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
