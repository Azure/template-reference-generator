param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.Purview/accounts@2021-07-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
