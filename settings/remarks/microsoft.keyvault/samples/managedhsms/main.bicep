param location string = 'westeurope'

resource managedHSM 'Microsoft.KeyVault/managedHSMs@2021-10-01' = {
  name: 'kvHsm230630033342437496'
  location: location
  properties: {
    createMode: 'default'
    enablePurgeProtection: false
    enableSoftDelete: true
    initialAdminObjectIds: [
      deployer().objectId
    ]
    publicNetworkAccess: 'Enabled'
    softDeleteRetentionInDays: 90
    tenantId: deployer().tenantId
  }
  sku: {
    family: 'B'
    name: 'Standard_B1'
  }
}
