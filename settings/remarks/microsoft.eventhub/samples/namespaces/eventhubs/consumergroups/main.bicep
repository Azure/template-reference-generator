param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
  }
}

resource eventhub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  name: resourceName
  parent: namespace
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

resource consumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumerGroups@2021-11-01' = {
  name: resourceName
  parent: eventhub
  properties: {
    userMetadata: ''
  }
}
