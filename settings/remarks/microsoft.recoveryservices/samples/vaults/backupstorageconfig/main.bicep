param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'Standard'
  }
}

resource backupStorageConfig 'Microsoft.RecoveryServices/vaults/backupStorageConfig@2023-02-01' = {
  parent: vault
  name: 'vaultstorageconfig'
  properties: {
    crossRegionRestoreFlag: false
    storageModelType: 'GeoRedundant'
  }
}
