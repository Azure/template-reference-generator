targetScope = 'subscription'

param resourceName string = 'acctest0001'

resource connector 'Microsoft.Impact/connectors@2024-05-01-preview' = {
  name: resourceName
  properties: {
    connectorType: 'AzureMonitor'
  }
}
