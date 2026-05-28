param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
}

resource mediaService 'Microsoft.Media/mediaServices@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    storageAccounts: [
      {
        id: storageAccount.id
        type: 'Primary'
      }
    ]
  }
}

resource liveEvent 'Microsoft.Media/mediaServices/liveEvents@2022-08-01' = {
  name: resourceName
  location: location
  parent: mediaService
  properties: {
    input: {
      accessControl: {
        ip: {
          allow: [
            {
              address: '0.0.0.0'
              name: 'AllowAll'
              subnetPrefixLength: 0
            }
          ]
        }
      }
      keyFrameIntervalDuration: 'PT6S'
      streamingProtocol: 'RTMP'
    }
  }
}
