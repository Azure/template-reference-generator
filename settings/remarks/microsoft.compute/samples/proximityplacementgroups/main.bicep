param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource proximityPlacementGroup 'Microsoft.Compute/proximityPlacementGroups@2022-03-01' = {
  name: resourceName
  location: location
  properties: {}
}
