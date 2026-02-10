param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2023-04-02-preview' = {
  name: resourceName
  location: location
  properties: {
    agentPoolProfiles: [
      {
        mode: 'System'
        name: 'default'
        vmSize: 'Standard_DS2_v2'
        count: 1
      }
    ]
    dnsPrefix: '${resourceName}'
  }
}

resource agentPool 'Microsoft.ContainerService/managedClusters/agentPools@2023-04-02-preview' = {
  name: 'internal'
  parent: managedCluster
  properties: {
    vmSize: 'Standard_DS2_v2'
    count: 1
    mode: 'User'
  }
}
