param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource diskAccess 'Microsoft.Compute/diskAccesses@2022-03-02' = {
  name: resourceName
  location: location
  tags: {
    environment: 'acctest'
    'cost-center': 'ops'
  }
}
