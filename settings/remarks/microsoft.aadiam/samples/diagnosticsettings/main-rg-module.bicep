param resourceName string = 'acctest0001'
param location string = 'westus'

resource namespace 'Microsoft.EventHub/namespaces@2024-01-01' = {
  name: '${resourceName}-EHN-unique'
  location: location
  sku: {
    capacity: 1
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
  }
}

resource authorizationRule 'Microsoft.EventHub/namespaces/authorizationRules@2024-01-01' = {
  name: 'example'
  parent: namespace
  properties: {
    rights: [
      'Listen'
      'Send'
      'Manage'
    ]
  }
}

resource eventhub 'Microsoft.EventHub/namespaces/eventhubs@2024-01-01' = {
  name: '${resourceName}-EH-unique'
  parent: namespace
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

// Module outputs for cross-scope references
output authorizationRuleId string = authorizationRule.id
output eventhubName string = eventhub.name
