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

resource hybridConnection 'Microsoft.Relay/namespaces/hybridConnections@2017-04-01' = {
  name: resourceName
  parent: namespace
  properties: {
    userMetadata: 'metadatatest'
    requiresClientAuthorization: true
  }
}
