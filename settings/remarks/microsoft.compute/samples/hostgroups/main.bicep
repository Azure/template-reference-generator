param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource hostGroup 'Microsoft.Compute/hostGroups@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    platformFaultDomainCount: 2
  }
}
