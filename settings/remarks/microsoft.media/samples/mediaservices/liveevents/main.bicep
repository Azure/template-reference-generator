param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_GRS'
  }
}

resource liveEvent 'Microsoft.Media/mediaServices/liveEvents@2022-08-01' = {
  parent: mediaService
  name: resourceName
  location: location
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
