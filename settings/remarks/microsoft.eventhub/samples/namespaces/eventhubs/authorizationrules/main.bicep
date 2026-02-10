param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    zoneRedundant: false
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
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

resource authorizationRule 'Microsoft.EventHub/namespaces/eventhubs/authorizationRules@2021-11-01' = {
  name: resourceName
  parent: eventhub
  properties: {
    rights: [
      'Send'
    ]
  }
}
