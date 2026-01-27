param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2024-04-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'Standard'
  }
}

resource softDeleteRetentionPeriodInDays 'Microsoft.RecoveryServices/vaults/backupconfig@2024-04-01' = {
  parent: vault
  name: 'vaultconfig'
  properties: {
    softDeleteRetentionPeriodInDays: 14
  }
}
