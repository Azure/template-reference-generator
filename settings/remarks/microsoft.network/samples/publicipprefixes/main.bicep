param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource publicIPPrefix 'Microsoft.Network/publicIPPrefixes@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    prefixLength: 30
    publicIPAddressVersion: 'IPv4'
  }
  sku: {
    name: 'Standard'
  }
  zones: [
    '1'
  ]
}
