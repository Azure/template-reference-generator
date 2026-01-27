param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource topic 'Microsoft.EventGrid/topics@2021-12-01' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    inputSchema: 'EventGridSchema'
    inputSchemaMapping: null
    publicNetworkAccess: 'Enabled'
  }
}
