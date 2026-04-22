param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource backupStorageConfig 'Microsoft.RecoveryServices/vaults/backupStorageConfig@2023-02-01' = {
  name: 'vaultstorageconfig'
  parent: vault
  properties: {
    crossRegionRestoreFlag: false
    storageModelType: 'GeoRedundant'
  }
}
