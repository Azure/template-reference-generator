param resourceName string = 'acctest0001'
param location string = 'westus'

resource capacityReservationGroup 'Microsoft.Compute/capacityReservationGroups@2022-03-01' = {
  name: '${resourceName}-ccrg'
  location: location
}

resource capacityReservation 'Microsoft.Compute/capacityReservationGroups/capacityReservations@2022-03-01' = {
  parent: capacityReservationGroup
  name: '${resourceName}-ccr'
  location: location
  sku: {
    capacity: 2
    name: 'Standard_F2'
  }
}
