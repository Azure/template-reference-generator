param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedHSM 'Microsoft.KeyVault/managedHSMs@2021-10-01' = {
  name: 'kvHsm230630033342437496'
  location: location
  sku: {
    family: 'B'
    name: 'Standard_B1'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    softDeleteRetentionInDays: 90
    tenantId: tenant().tenantId
    createMode: 'default'
    enablePurgeProtection: false
    enableSoftDelete: true
    initialAdminObjectIds: [
      deployer().objectId
    ]
  }
}
