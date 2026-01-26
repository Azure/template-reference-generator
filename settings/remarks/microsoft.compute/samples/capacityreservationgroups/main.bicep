param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource capacityReservationGroup 'Microsoft.Compute/capacityReservationGroups@2022-03-01' = {
  name: resourceName
  location: location
}
