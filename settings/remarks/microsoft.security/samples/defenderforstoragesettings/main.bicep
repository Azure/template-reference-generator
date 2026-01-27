param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource defenderForStorageSetting 'Microsoft.Security/defenderForStorageSettings@2022-12-01-preview' = {
  scope: storageAccount
  name: 'current'
  properties: {
    isEnabled: true
    malwareScanning: {
      onUpload: {
        capGBPerMonth: 5000
        isEnabled: true
      }
    }
    overrideSubscriptionLevelSettings: true
    sensitiveDataDiscovery: {
      isEnabled: true
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  kind: 'StorageV2'
  properties: {}
  sku: {
    name: 'Standard_LRS'
  }
}
