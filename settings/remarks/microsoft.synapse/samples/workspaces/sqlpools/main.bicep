param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The SQL administrator login name for the Synapse workspace')
param sqlAdministratorLogin string
@secure()
@description('The SQL administrator login password for the Synapse workspace')
param sqlAdministratorLoginPassword string

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' existing = {
  name: 'default'
  parent: storageAccount
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

resource workspace 'Microsoft.Synapse/workspaces@2021-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    defaultDataLakeStorage: {
      accountUrl: storageAccount.properties.primaryEndpoints.dfs
    }
    managedVirtualNetwork: ''
  }
}

resource sqlPool 'Microsoft.Synapse/workspaces/sqlPools@2021-06-01' = {
  name: resourceName
  location: location
  parent: workspace
  sku: {
    name: 'DW100c'
  }
  properties: {
    createMode: 'Default'
  }
}
