param resourceName string = 'acctest0001'
param location string = 'eastus'

resource storageMover 'Microsoft.StorageMover/storageMovers@2023-03-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource project 'Microsoft.StorageMover/storageMovers/projects@2023-03-01' = {
  name: resourceName
  parent: storageMover
  properties: {}
}
