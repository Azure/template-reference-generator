param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource fileService 'Microsoft.Storage/storageAccounts/fileServices@2022-09-01' existing = {
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

resource share 'Microsoft.Storage/storageAccounts/fileServices/shares@2022-09-01' = {
  parent: fileService
  name: resourceName
  properties: {
    accessTier: 'Cool'
  }
}
