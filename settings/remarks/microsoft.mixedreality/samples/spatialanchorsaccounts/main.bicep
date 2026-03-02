param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource spatialAnchorsAccount 'Microsoft.MixedReality/spatialAnchorsAccounts@2021-01-01' = {
  name: resourceName
  location: location
}
