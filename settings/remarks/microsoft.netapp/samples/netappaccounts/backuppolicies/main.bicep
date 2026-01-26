param resourceName string = 'acctest0001'
param location string = 'westus'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2025-01-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource backupPolicy 'Microsoft.NetApp/netAppAccounts/backupPolicies@2025-01-01' = {
  parent: netAppAccount
  name: '${resourceName}-policy'
  location: location
  properties: {
    dailyBackupsToKeep: 2
    enabled: true
    monthlyBackupsToKeep: 1
    weeklyBackupsToKeep: 1
  }
}
