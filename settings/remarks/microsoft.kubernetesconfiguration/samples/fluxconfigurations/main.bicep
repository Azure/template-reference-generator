param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    dnsPrefix: resourceName
  }
}

resource extension 'Microsoft.KubernetesConfiguration/extensions@2022-11-01' = {
  name: resourceName
  scope: managedCluster
  properties: {
    autoUpgradeMinorVersion: true
    extensionType: 'microsoft.flux'
  }
}

resource fluxConfiguration 'Microsoft.KubernetesConfiguration/fluxConfigurations@2022-03-01' = {
  name: resourceName
  scope: managedCluster
  dependsOn: [
    extension
  ]
  properties: {
    gitRepository: {
      repositoryRef: {
        branch: 'branch'
      }
      syncIntervalInSeconds: 120
      timeoutInSeconds: 120
      url: 'https://github.com/Azure/arc-k8s-demo'
    }
    kustomizations: {
      applications: {
        dependsOn: [
          'shared'
        ]
        force: false
        path: 'cluster-config/applications'
        prune: false
        retryIntervalInSeconds: 60
        syncIntervalInSeconds: 60
        timeoutInSeconds: 600
      }
      shared: {
        force: false
        path: 'cluster-config/shared'
        prune: false
        retryIntervalInSeconds: 60
        syncIntervalInSeconds: 60
        timeoutInSeconds: 600
      }
    }
    namespace: 'flux-system'
    scope: 'cluster'
    sourceKind: 'GitRepository'
    suspend: false
  }
}
