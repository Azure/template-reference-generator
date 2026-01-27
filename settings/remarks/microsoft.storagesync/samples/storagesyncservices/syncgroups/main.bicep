param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageSyncService 'Microsoft.StorageSync/storageSyncServices@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    incomingTrafficPolicy: 'AllowAllTraffic'
  }
}

resource syncGroup 'Microsoft.StorageSync/storageSyncServices/syncGroups@2020-03-01' = {
  parent: storageSyncService
  name: resourceName
}
