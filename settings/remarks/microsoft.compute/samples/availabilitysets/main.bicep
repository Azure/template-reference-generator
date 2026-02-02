param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource availabilitySet 'Microsoft.Compute/availabilitySets@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    platformFaultDomainCount: 3
    platformUpdateDomainCount: 5
  }
  sku: {
    name: 'Aligned'
  }
}
