param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.Maps/accounts@2021-02-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'G2'
  }
}

resource creator 'Microsoft.Maps/accounts/creators@2021-02-01' = {
  parent: account
  name: resourceName
  location: location
  properties: {
    storageUnits: 1
  }
}
