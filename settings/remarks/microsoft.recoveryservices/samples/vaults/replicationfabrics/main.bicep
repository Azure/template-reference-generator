param location string = 'westus2'
param resourceName string = 'acctest0001'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource replicationFabric2 'Microsoft.RecoveryServices/vaults/replicationFabrics@2022-10-01' = {
  name: resourceName
  parent: vault
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: '${location}'
    }
  }
}
