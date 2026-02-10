param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource queueService 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' existing = {
  name: 'default'
  parent: storageAccount
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {}
}

resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  name: resourceName
  parent: queueService
  properties: {
    metadata: {
      key: 'value'
    }
  }
}
