param location string = 'westus'
@secure()
@description('The administrator login password for the SQL server')
param administratorLoginPassword string
@secure()
@description('The password for the SQL job credential')
param jobCredentialPassword string
param resourceName string = 'acctest0001'

var maintenanceConfigId = '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'

resource server 'Microsoft.Sql/servers@2023-08-01-preview' = {
  name: '${resourceName}-server'
  location: location
  properties: {
    administratorLogin: '4dm1n157r470r'
    administratorLoginPassword: '${administratorLoginPassword}'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    version: '12.0'
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
    password: '${jobCredentialPassword}'
    username: 'testusername'
  }
}

resource job 'Microsoft.Sql/servers/jobAgents/jobs@2023-08-01-preview' = {
  name: '${resourceName}-job'
  parent: jobAgent
  properties: {
    description: ''
  }
}

resource targetGroup 'Microsoft.Sql/servers/jobAgents/targetGroups@2023-08-01-preview' = {
  name: '${resourceName}-target-group'
  parent: jobAgent
  properties: {
    members: []
  }
}

resource step 'Microsoft.Sql/servers/jobAgents/jobs/steps@2023-08-01-preview' = {
  name: '${resourceName}-job-step'
  parent: job
  properties: {
    stepId: 1
    targetGroup: targetGroup.id
    action: {
      value: '''IF NOT EXISTS (SELECT * FROM sys.objects WHERE [name] = N''Person'')
  CREATE TABLE Person (
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
  );
'''
    }
    credential: credential.id
    executionOptions: {
      initialRetryIntervalSeconds: 1
      maximumRetryIntervalSeconds: 120
      retryAttempts: 10
      retryIntervalBackoffMultiplier: 2
      timeoutSeconds: 43200
    }
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
    createMode: 'Default'
    maintenanceConfigurationId: '${maintenanceConfigId}'
  }
}
