param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spatialAnchorsAccount 'Microsoft.MixedReality/spatialAnchorsAccounts@2021-01-01' = {
  name: resourceName
  location: location
}
