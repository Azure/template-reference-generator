param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 0
  }
  properties: {
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
}

resource queue 'Microsoft.ServiceBus/namespaces/queues@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    deadLetteringOnMessageExpiration: false
    enableExpress: false
    maxDeliveryCount: 10
    maxSizeInMegabytes: 81920
    requiresSession: false
    status: 'Active'
    enableBatchedOperations: true
    enablePartitioning: true
    requiresDuplicateDetection: false
  }
}
