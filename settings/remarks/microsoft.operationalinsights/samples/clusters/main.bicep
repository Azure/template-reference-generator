param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.OperationalInsights/clusters@2020-08-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'CapacityReservation'
    capacity: 1000
  }
}
