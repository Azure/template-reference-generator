param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource putSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  parent: vault
  name: resourceName
  properties: {
    value: 'szechuan'
  }
}
