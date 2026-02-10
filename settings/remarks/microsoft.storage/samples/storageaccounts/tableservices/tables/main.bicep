param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource tableService 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' existing = {
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

resource table 'Microsoft.Storage/storageAccounts/tableServices/tables@2022-09-01' = {
  name: resourceName
  parent: tableService
  properties: {
    signedIdentifiers: []
  }
}
