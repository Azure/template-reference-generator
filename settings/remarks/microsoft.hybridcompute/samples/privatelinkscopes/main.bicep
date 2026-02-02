param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateLinkScope 'Microsoft.HybridCompute/privateLinkScopes@2022-11-10' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Disabled'
  }
}
