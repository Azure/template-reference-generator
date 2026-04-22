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
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource backupResourceGuardProxy 'Microsoft.RecoveryServices/vaults/backupResourceGuardProxies@2023-02-01' = {
  name: resourceName
  parent: vault
  properties: {
    resourceGuardResourceId: resourceGuard.id
  }
}
