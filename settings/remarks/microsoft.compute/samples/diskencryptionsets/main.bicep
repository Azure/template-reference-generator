param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource diskEncryptionSet 'Microsoft.Compute/diskEncryptionSets@2022-03-02' = {
  name: resourceName
  location: location
  properties: {
    activeKey: {
      keyUrl: key.properties.keyUriWithVersion
      sourceVault: {
        id: vault.id
      }
    }
    encryptionType: 'EncryptionAtRestWithCustomerKey'
    rotationToLatestKeyVersionEnabled: false
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: []
    enableSoftDelete: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: deployer().tenantId
  }
}

resource key 'Microsoft.KeyVault/vaults/keys@2023-02-01' = {
  parent: vault
  name: resourceName
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
