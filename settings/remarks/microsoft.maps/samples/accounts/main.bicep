param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.Maps/accounts@2021-02-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'G2'
  }
}
