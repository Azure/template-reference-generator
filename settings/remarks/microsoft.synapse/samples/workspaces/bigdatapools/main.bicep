@secure()
@description('The SQL administrator login password for the Synapse workspace')
param sqlAdministratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The SQL administrator login for the Synapse workspace')
param sqlAdministratorLogin string

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
    sqlAdministratorLoginPassword: sqlAdministratorLoginPassword
    defaultDataLakeStorage: {
      accountUrl: storageAccount.properties.primaryEndpoints.dfs
    }
    managedVirtualNetwork: ''
    publicNetworkAccess: 'Enabled'
    sqlAdministratorLogin: sqlAdministratorLogin
  }
}

resource bigDataPool 'Microsoft.Synapse/workspaces/bigDataPools@2021-06-01-preview' = {
  name: resourceName
  location: location
  parent: workspace
  properties: {
    defaultSparkLogFolder: '/logs'
    dynamicExecutorAllocation: {
      minExecutors: 0
      enabled: false
      maxExecutors: 0
    }
    nodeCount: 3
    nodeSize: 'Small'
    nodeSizeFamily: 'MemoryOptimized'
    isComputeIsolationEnabled: false
    sessionLevelPackagesEnabled: false
    sparkEventsFolder: '/events'
    sparkVersion: '2.4'
    autoPause: {
      enabled: false
    }
    autoScale: {
      enabled: false
    }
    cacheSize: 0
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
