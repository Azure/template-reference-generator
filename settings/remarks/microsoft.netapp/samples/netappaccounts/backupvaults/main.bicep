param resourceName string = 'acctest0001'
param location string = 'westus'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2025-01-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource backupVault 'Microsoft.NetApp/netAppAccounts/backupVaults@2025-01-01' = {
  name: '${resourceName}-backupvault'
  location: location
  parent: netAppAccount
}
