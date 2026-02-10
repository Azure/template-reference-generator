param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource domain 'Microsoft.EventGrid/domains@2021-12-01' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    inputSchema: 'EventGridSchema'
    inputSchemaMapping: null
    publicNetworkAccess: 'Enabled'
    autoCreateTopicWithFirstSubscription: true
    autoDeleteTopicWithLastSubscription: true
  }
}
