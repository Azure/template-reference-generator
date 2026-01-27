param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' existing = {
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

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: blobService
  name: resourceName
  properties: {
    metadata: {
      key: 'value'
    }
  }
}

resource immutabilityPolicy 'Microsoft.Storage/storageAccounts/blobServices/containers/immutabilityPolicies@2023-05-01' = {
  parent: container
  name: 'default'
  properties: {
    allowProtectedAppendWrites: false
    immutabilityPeriodSinceCreationInDays: 4
  }
}
