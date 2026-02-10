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
    defaultDataLakeStorage: {
      accountUrl: storageAccount.properties.primaryEndpoints.dfs
    }
    managedVirtualNetwork: ''
    publicNetworkAccess: 'Enabled'
    sqlAdministratorLogin: sqlAdministratorLogin
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
  }
}

resource securityAlertPolicy 'Microsoft.Synapse/workspaces/securityAlertPolicies@2021-06-01' = {
  name: 'Default'
  parent: workspace
  properties: {
    state: 'Enabled'
    storageAccountAccessKey: storageAccount.listKeys().keys[0].value
    storageEndpoint: storageAccount.properties.primaryEndpoints.blob
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
