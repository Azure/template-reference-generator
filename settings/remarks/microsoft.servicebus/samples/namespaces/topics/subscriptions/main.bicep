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

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  name: resourceName
  parent: namespace
  properties: {
    enableExpress: false
    enablePartitioning: false
    maxSizeInMegabytes: 5120
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
    enableBatchedOperations: false
  }
}

resource subscription 'Microsoft.ServiceBus/namespaces/topics/subscriptions@2021-06-01-preview' = {
  name: resourceName
  parent: topic
  properties: {
    isClientAffine: false
    requiresSession: false
    clientAffineProperties: {}
    maxDeliveryCount: 10
    status: 'Active'
    deadLetteringOnFilterEvaluationExceptions: true
    deadLetteringOnMessageExpiration: false
    enableBatchedOperations: false
  }
}
