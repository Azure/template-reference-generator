param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource tableService 'Microsoft.Storage/storageAccounts/tableServices@2022-09-01' existing = {
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

resource table 'Microsoft.Storage/storageAccounts/tableServices/tables@2022-09-01' = {
  parent: tableService
  name: resourceName
  properties: {
    signedIdentifiers: []
  }
}
