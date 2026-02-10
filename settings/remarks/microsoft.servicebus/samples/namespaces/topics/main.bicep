param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    capacity: 0
    name: 'Standard'
  }
  properties: {
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    enablePartitioning: true
    maxSizeInMegabytes: 81920
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
    enableBatchedOperations: false
    enableExpress: false
  }
}
