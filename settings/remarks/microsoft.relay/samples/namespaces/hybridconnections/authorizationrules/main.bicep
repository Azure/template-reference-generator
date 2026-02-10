param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.Relay/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {}
}

resource hybridConnection 'Microsoft.Relay/namespaces/hybridConnections@2017-04-01' = {
  name: resourceName
  parent: namespace
  properties: {
    requiresClientAuthorization: true
    userMetadata: ''
  }
}

resource authorizationRule 'Microsoft.Relay/namespaces/hybridConnections/authorizationRules@2017-04-01' = {
  name: resourceName
  parent: hybridConnection
  properties: {
    rights: [
      'Listen'
      'Send'
    ]
  }
}
