param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.DeviceUpdate/accounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sku: 'Standard'
  }
}
