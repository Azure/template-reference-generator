param resourceName string = 'acctest0001'
param location string = 'westus2'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
  sku: {
    name: 'Standard'
  }
}

resource replicationFabric2 'Microsoft.RecoveryServices/vaults/replicationFabrics@2022-10-01' = {
  parent: vault
  name: resourceName
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'westus2'
    }
  }
}
