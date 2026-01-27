param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource diskAccess 'Microsoft.Compute/diskAccesses@2022-03-02' = {
  name: resourceName
  location: location
  tags: {
    'cost-center': 'ops'
    environment: 'acctest'
  }
}
