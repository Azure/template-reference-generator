param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
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
        tenantId: tenant()
      }
    ]
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant()
    createMode: 'default'
    enableRbacAuthorization: false
    softDeleteRetentionInDays: 7
  }
}
