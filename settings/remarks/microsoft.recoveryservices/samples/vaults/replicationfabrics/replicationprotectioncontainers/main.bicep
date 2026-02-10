param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource replicationFabric 'Microsoft.RecoveryServices/vaults/replicationFabrics@2022-10-01' = {
  name: resourceName
  parent: vault
  properties: {
    customDetails: {
      location: '${location}'
      instanceType: 'Azure'
    }
  }
}

resource replicationProtectionContainer 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationProtectionContainers@2022-10-01' = {
  name: resourceName
  parent: replicationFabric
  properties: {}
}
