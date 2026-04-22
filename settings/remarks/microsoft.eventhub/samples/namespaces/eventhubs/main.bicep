param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    capacity: 1
    name: 'Standard'
  }
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
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
