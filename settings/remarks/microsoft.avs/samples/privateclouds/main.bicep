param location string = 'centralus'
param resourceName string = 'acctest0001'

resource privateCloud 'Microsoft.AVS/privateClouds@2022-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'av36'
  }
  properties: {
    internet: 'Disabled'
    managementCluster: {
      clusterSize: 3
    }
    networkBlock: '192.168.48.0/22'
  }
}
