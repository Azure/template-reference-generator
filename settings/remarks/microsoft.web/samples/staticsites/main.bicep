param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource staticSite 'Microsoft.Web/staticSites@2021-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {}
}
