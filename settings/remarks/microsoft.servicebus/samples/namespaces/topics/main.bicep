param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    capacity: 0
    name: 'Standard'
    tier: 'Standard'
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  parent: namespace
  name: resourceName
  properties: {
    enableBatchedOperations: false
    enableExpress: false
    enablePartitioning: true
    maxSizeInMegabytes: 81920
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
  }
}
