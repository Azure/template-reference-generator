param location string = 'westeurope'
@description('The SQL administrator login for the Synapse workspace')
param sqlAdministratorLogin string
@secure()
@description('The SQL administrator login password for the Synapse workspace')
param sqlAdministratorLoginPassword string
param resourceName string = 'acctest0001'

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' existing = {
  name: 'default'
  parent: storageAccount
}

resource workspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: resourceName
  location: location
  properties: {
    defaultDataLakeStorage: {
      accountUrl: storageAccount.properties.primaryEndpoints.dfs
    }
    managedVirtualNetwork: ''
    publicNetworkAccess: 'Enabled'
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
  }
}

resource firewallRule 'Microsoft.Synapse/workspaces/firewallRules@2021-06-01' = {
  name: 'AllowAll'
  parent: workspace
  properties: {
    endIpAddress: '255.255.255.255'
    startIpAddress: '0.0.0.0'
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: resourceName
  parent: blobService
  properties: {
    metadata: {
      key: 'value'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {}
}
