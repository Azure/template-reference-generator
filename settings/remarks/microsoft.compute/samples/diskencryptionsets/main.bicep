param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-03-02' = {
  name: resourceName
  location: location
  properties: {
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: false
    activeKey: {
      sourceVault: {}
    }
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: []
    enableSoftDelete: true
    tenantId: tenant()
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

resource key 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  name: resourceName
  parent: vault
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
