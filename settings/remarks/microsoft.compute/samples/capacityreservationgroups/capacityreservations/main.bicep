param location string = 'westus'
param resourceName string = 'acctest0001'

resource capacityReservationGroup 'Microsoft.Compute/capacityReservationGroups@2022-03-01' = {
  name: '${resourceName}-ccrg'
  location: location
}

resource capacityReservation 'Microsoft.Compute/capacityReservationGroups/capacityReservations@2022-03-01' = {
  name: '${resourceName}-ccr'
  location: location
  parent: capacityReservationGroup
  sku: {
    capacity: 2
    name: 'Standard_F2'
  }
}
