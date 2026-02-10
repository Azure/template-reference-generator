param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    softDeleteRetentionInDays: 7
    enableRbacAuthorization: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    tenantId: tenant().tenantId
    accessPolicies: [
      {
        objectId: deployer().objectId
        permissions: {
          certificates: [
            'ManageContacts'
          ]
          keys: [
            'Create'
          ]
          secrets: [
            'Set'
          ]
          storage: []
        }
        tenantId: tenant().tenantId
      }
    ]
    createMode: 'default'
    enableSoftDelete: true
    enabledForDeployment: false
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}
