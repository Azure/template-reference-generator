param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.EventHub/clusters@2021-11-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Dedicated'
  }
}
