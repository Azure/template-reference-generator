param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource configurationStore 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    disableLocalAuth: false
    enablePurgeProtection: false
  }
}
