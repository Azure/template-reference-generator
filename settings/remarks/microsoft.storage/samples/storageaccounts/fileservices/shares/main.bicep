param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource fileService 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' existing = {
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

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  name: resourceName
  parent: fileService
  properties: {
    accessTier: 'Cool'
  }
}
