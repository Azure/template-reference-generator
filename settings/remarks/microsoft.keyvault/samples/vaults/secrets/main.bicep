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

resource putSecret 'Microsoft.KeyVault/vaults/secrets@2023-02-01' = {
  name: resourceName
  parent: vault
  properties: {
    value: 'szechuan'
  }
}
