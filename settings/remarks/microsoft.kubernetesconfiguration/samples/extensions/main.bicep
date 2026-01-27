param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource extension 'Microsoft.KubernetesConfiguration/extensions@2022-11-01' = {
  scope: managedCluster
  name: resourceName
  properties: {
    autoUpgradeMinorVersion: true
    extensionType: 'microsoft.flux'
  }
}

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
