param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.Relay/namespaces@2017-04-01' = {
  name: resourceName
  location: location
  properties: {}
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}

resource hybridConnection 'Microsoft.Relay/namespaces/hybridConnections@2017-04-01' = {
  parent: namespace
  name: resourceName
  properties: {
    requiresClientAuthorization: true
    userMetadata: ''
  }
}

resource authorizationRule 'Microsoft.Relay/namespaces/hybridConnections/authorizationRules@2017-04-01' = {
  parent: hybridConnection
  name: resourceName
  properties: {
    rights: [
      'Listen'
      'Send'
    ]
  }
}
