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
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: administratorLoginPassword
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
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
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    createMode: 'Default'
    elasticPoolId: ''
    encryptionProtectorAutoRotation: false
    highAvailabilityReplicaCount: 0
    isLedgerOn: false
    licenseType: ''
    maintenanceConfigurationId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    minCapacity: 0
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Geo'
    sampleName: ''
    secondaryType: ''
    zoneRedundant: false
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

resource credential 'Microsoft.Sql/servers/jobAgents/credentials@2023-08-01-preview' = {
  name: '${resourceName}-job-credential'
  parent: jobAgent
  properties: {
    password: jobCredentialPassword
    username: 'testusername'
  }
}

resource targetGroup 'Microsoft.Sql/servers/jobAgents/targetGroups@2023-08-01-preview' = {
  name: '${resourceName}-target-group'
  parent: jobAgent
  properties: {
    members: []
  }
}
