param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
  properties: {
    originResponseTimeoutSeconds: 120
  }
}
