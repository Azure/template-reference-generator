targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource connector 'Microsoft.Impact/connectors@2024-05-01-preview' = {
  name: resourceName
  properties: {
    connectorType: 'AzureMonitor'
  }
}
