param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.StreamAnalytics/clusters@2020-03-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 36
    name: 'Default'
  }
}
