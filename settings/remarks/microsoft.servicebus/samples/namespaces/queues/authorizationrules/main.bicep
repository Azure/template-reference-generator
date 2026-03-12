param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Standard'
    tier: 'Standard'
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
    enablePartitioning: true
    maxDeliveryCount: 10
    requiresDuplicateDetection: false
    status: 'Active'
    enableBatchedOperations: true
    maxSizeInMegabytes: 81920
    requiresSession: false
  }
}

resource authorizationRule 'Microsoft.ServiceBus/namespaces/queues/authorizationRules@2021-06-01-preview' = {
  name: resourceName
  parent: queue
  properties: {
    rights: [
      'Send'
    ]
  }
}
