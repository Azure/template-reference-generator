param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2023-04-02-preview' = {
  name: resourceName
  location: location
  properties: {
    agentPoolProfiles: [
      {
        name: 'default'
        vmSize: 'Standard_DS2_v2'
        count: 1
        mode: 'System'
      }
    ]
    dnsPrefix: '${resourceName}'
  }
}

resource extension 'Microsoft.KubernetesConfiguration/extensions@2022-11-01' = {
  name: resourceName
  scope: managedCluster
  properties: {
    extensionType: 'microsoft.flux'
    autoUpgradeMinorVersion: true
  }
}
