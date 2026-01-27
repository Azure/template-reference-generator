param resourceName string = 'acctest0001'

resource profile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: resourceName
  location: 'global'
  properties: {
    originResponseTimeoutSeconds: 120
  }
  sku: {
    name: 'Premium_AzureFrontDoor'
  }
}
