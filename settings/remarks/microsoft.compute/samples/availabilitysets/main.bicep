param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource availabilitySet 'Microsoft.Compute/availabilitySets@2021-11-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Aligned'
  }
  properties: {
    platformFaultDomainCount: 3
    platformUpdateDomainCount: 5
  }
}
