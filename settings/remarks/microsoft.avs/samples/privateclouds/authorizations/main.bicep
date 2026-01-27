param resourceName string = 'acctest0001'
param location string = 'centralus'

resource privateCloud 'Microsoft.AVS/privateClouds@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    internet: 'Disabled'
    managementCluster: {
      clusterSize: 3
    }
    networkBlock: '192.168.48.0/22'
  }
  sku: {
    name: 'av36'
  }
}

resource authorization 'Microsoft.AVS/privateClouds/authorizations@2022-05-01' = {
  parent: privateCloud
  name: resourceName
}
