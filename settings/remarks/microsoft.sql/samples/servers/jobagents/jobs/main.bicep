param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: '${administratorLoginPassword}'
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
    autoPauseDelay: 0
    maintenanceConfigurationId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    sampleName: ''
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    elasticPoolId: ''
    readScale: 'Disabled'
    zoneRedundant: false
    createMode: 'Default'
    encryptionProtectorAutoRotation: false
    licenseType: ''
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    minCapacity: 0
    requestedBackupStorageRedundancy: 'Geo'
    secondaryType: ''
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
