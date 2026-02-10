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

resource authorizationRule 'Microsoft.ServiceBus/namespaces/topics/authorizationRules@2021-06-01-preview' = {
  name: resourceName
  parent: topic
  properties: {
    rights: [
      'Send'
    ]
  }
}
