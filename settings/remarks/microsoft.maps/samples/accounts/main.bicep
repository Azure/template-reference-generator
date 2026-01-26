param resourceName string = 'acctest0001'

resource account 'Microsoft.Maps/accounts@2021-02-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'G2'
  }
}
