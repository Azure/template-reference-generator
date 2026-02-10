param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource vault 'Microsoft.RecoveryServices/vaults@2024-04-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource softDeleteRetentionPeriodInDays 'Microsoft.RecoveryServices/vaults/backupconfig@2024-04-01' = {
  name: 'vaultconfig'
  parent: vault
  properties: {
    softDeleteRetentionPeriodInDays: 14
  }
}
