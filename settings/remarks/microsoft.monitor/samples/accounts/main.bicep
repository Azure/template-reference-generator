param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.Monitor/accounts@2023-04-03' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
