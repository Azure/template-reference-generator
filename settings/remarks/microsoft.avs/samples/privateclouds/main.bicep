param resourceName string = 'acctest0001'
param location string = 'centralus'

resource privateCloud 'Microsoft.AVS/privateClouds@2022-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'av36'
  }
  properties: {
    networkBlock: '192.168.48.0/22'
    internet: 'Disabled'
    managementCluster: {
      clusterSize: 3
    }
  }
}
