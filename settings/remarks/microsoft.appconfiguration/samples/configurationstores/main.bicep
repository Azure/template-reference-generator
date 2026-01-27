param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource configurationStore 'Microsoft.AppConfiguration/configurationStores@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    enablePurgeProtection: false
  }
  sku: {
    name: 'standard'
  }
}
