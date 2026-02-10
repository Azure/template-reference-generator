param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    enableSoftDelete: true
    tenantId: tenant()
  }
}

resource putAccesspolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: 'add'
  parent: vault
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
  }
}
