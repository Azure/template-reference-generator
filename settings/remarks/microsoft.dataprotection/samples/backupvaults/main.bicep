param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource backupVault 'Microsoft.DataProtection/backupVaults@2022-04-01' = {
  name: resourceName
  location: location
  properties: {
    storageSettings: [
      {
        type: 'LocallyRedundant'
        datastoreType: 'VaultStore'
      }
    ]
  }
}
