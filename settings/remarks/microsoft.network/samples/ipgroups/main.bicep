param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource ipGroup 'Microsoft.Network/ipGroups@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ipAddresses: []
  }
  tags: {
    env: 'prod'
  }
}
