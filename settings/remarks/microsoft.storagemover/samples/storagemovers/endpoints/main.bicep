param resourceName string = 'acctest0001'
param location string = 'eastus'

resource storageMover 'Microsoft.StorageMover/storageMovers@2023-03-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource endpoint 'Microsoft.StorageMover/storageMovers/endpoints@2023-03-01' = {
  name: resourceName
  parent: storageMover
  properties: {
    host: '192.168.0.1'
    nfsVersion: 'NFSauto'
    endpointType: 'NfsMount'
    export: ''
  }
}
