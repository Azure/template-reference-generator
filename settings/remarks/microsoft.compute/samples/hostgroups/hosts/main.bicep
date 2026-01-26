param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource hostGroup 'Microsoft.Compute/hostGroups@2021-11-01' = {
  name: resourceName
  location: location
  properties: {
    platformFaultDomainCount: 2
  }
}

resource host 'Microsoft.Compute/hostGroups/hosts@2021-11-01' = {
  parent: hostGroup
  name: resourceName
  location: location
  properties: {
    autoReplaceOnFailure: true
    licenseType: 'None'
    platformFaultDomain: 1
  }
  sku: {
    name: 'DSv3-Type1'
  }
}
