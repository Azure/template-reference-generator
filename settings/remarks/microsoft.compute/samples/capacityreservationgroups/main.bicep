param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource capacityReservationGroup 'Microsoft.Compute/capacityReservationGroups@2022-03-01' = {
  name: resourceName
  location: location
}
