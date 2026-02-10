param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {}
}

resource batchConfiguration 'Microsoft.Logic/integrationAccounts/batchConfigurations@2019-05-01' = {
  name: resourceName
  parent: integrationAccount
  properties: {
    batchGroupName: 'TestBatchGroup'
    releaseCriteria: {
      messageCount: 80
    }
  }
}
