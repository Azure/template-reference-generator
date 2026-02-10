param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
  }
}

resource queue 'Microsoft.ServiceBus/namespaces/queues@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    enableBatchedOperations: true
    enableExpress: false
    status: 'Active'
    enablePartitioning: true
    maxDeliveryCount: 10
    maxSizeInMegabytes: 81920
    requiresDuplicateDetection: false
    requiresSession: false
    deadLetteringOnMessageExpiration: false
  }
}
