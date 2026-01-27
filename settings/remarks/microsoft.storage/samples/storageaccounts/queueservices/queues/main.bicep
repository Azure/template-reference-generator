param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource queueService 'Microsoft.Storage/storageAccounts/queueServices@2022-09-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  properties: {}
  sku: {
    name: 'Standard_LRS'
  }
}

resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2022-09-01' = {
  parent: queueService
  name: resourceName
  properties: {
    metadata: {
      key: 'value'
    }
  }
}
