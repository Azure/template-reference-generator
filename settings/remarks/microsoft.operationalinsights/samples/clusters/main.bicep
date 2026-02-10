param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.OperationalInsights/clusters@2020-08-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1000
    name: 'CapacityReservation'
  }
}
