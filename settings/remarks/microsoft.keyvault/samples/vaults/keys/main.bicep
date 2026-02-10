param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'standard'
      family: 'A'
    }
    accessPolicies: []
    enableSoftDelete: true
    enablePurgeProtection: true
    tenantId: tenant().tenantId
  }
}

resource putAccesspolicy 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  name: 'add'
  parent: vault
  properties: {
    accessPolicies: [
      {
        tenantId: tenant().tenantId
        objectId: deployer().objectId
        permissions: {
          keys: [
            'Get'
            'Create'
            'Delete'
            'List'
            'Restore'
            'Recover'
            'UnwrapKey'
            'WrapKey'
            'Purge'
            'Encrypt'
            'Decrypt'
            'Sign'
            'Verify'
          ]
          secrets: [
            'Get'
          ]
          storage: []
          certificates: [
            'ManageContacts'
          ]
        }
      }
    ]
  }
}

resource putKey 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  name: resourceName
  parent: vault
  dependsOn: [
    putAccesspolicy
  ]
  properties: {
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
    keySize: 2048
    kty: 'RSA'
  }
}
