param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2023-04-02-preview' = {
  name: resourceName
  location: location
  properties: {
    agentPoolProfiles: [
      {
        count: 1
        mode: 'System'
        name: 'default'
        vmSize: 'Standard_DS2_v2'
      }
    ]
    dnsPrefix: 'acctest0001'
  }
}

resource agentPool 'Microsoft.ContainerService/managedClusters/agentPools@2023-04-02-preview' = {
  parent: managedCluster
  name: 'internal'
  properties: {
    count: 1
    mode: 'User'
    vmSize: 'Standard_DS2_v2'
  }
}
