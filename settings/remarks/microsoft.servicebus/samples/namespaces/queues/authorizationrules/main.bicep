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
    enableBatchedOperations: true
    enableExpress: false
    enablePartitioning: true
    maxDeliveryCount: 10
    maxSizeInMegabytes: 81920
    requiresDuplicateDetection: false
    requiresSession: false
    status: 'Active'
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
