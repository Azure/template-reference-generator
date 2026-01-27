param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource domain 'Microsoft.EventGrid/domains@2021-12-01' = {
  name: resourceName
  location: location
  properties: {
    autoCreateTopicWithFirstSubscription: true
    autoDeleteTopicWithLastSubscription: true
    disableLocalAuth: false
    inputSchema: 'EventGridSchema'
    inputSchemaMapping: null
    publicNetworkAccess: 'Enabled'
  }
}
