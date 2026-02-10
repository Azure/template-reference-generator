param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.Relay/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Standard'
    name: 'Standard'
  }
  properties: {}
}

resource authorizationRule 'Microsoft.Relay/namespaces/authorizationRules@2017-04-01' = {
  name: resourceName
  parent: namespace
  properties: {
    rights: [
      'Listen'
      'Send'
    ]
  }
}
