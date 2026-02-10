param resourceName string = 'acctest0001'
param location string = 'centralus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
@secure()
@description('The password for the SQL job credential')
param jobCredentialPassword string

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    version: '12.0'
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
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

resource targetGroup 'Microsoft.Sql/servers/jobAgents/targetGroups@2023-08-01-preview' = {
  name: '${resourceName}-target-group'
  parent: jobAgent
  properties: {
    members: []
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
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    zoneRedundant: false
    elasticPoolId: ''
    requestedBackupStorageRedundancy: 'Geo'
    secondaryType: ''
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    licenseType: ''
    maintenanceConfigurationId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    readScale: 'Disabled'
    createMode: 'Default'
    encryptionProtectorAutoRotation: false
    minCapacity: 0
    sampleName: ''
  }
}

resource credential 'Microsoft.Sql/servers/jobAgents/credentials@2023-08-01-preview' = {
  name: '${resourceName}-job-credential'
  parent: jobAgent
  properties: {
    password: '${jobCredentialPassword}'
    username: 'testusername'
  }
}
