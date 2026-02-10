param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: deployer().objectId
        permissions: {
          secrets: [
            'Set'
          ]
          storage: []
          certificates: [
            'ManageContacts'
          ]
          keys: [
            'Create'
          ]
        }
        tenantId: tenant().tenantId
      }
    ]
    enableRbacAuthorization: false
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    createMode: 'default'
    enableSoftDelete: true
  }
}
