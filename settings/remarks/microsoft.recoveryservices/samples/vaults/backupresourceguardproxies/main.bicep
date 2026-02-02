param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceGuard 'Microsoft.DataProtection/resourceGuards@2022-04-01' = {
  name: resourceName
  location: location
  properties: {
    vaultCriticalOperationExclusionList: []
  }
}

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

resource backupResourceGuardProxy 'Microsoft.RecoveryServices/vaults/backupResourceGuardProxies@2023-02-01' = {
  parent: vault
  name: resourceName
  properties: {
    resourceGuardResourceId: resourceGuard.id
  }
  type: 'Microsoft.RecoveryServices/vaults/backupResourceGuardProxies'
}
