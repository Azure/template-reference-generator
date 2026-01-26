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
    userMetadata: 'metadatatest'
  }
}
