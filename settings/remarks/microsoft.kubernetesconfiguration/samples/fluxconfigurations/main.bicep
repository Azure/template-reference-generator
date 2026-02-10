param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2023-04-02-preview' = {
  name: resourceName
  location: location
  properties: {
    agentPoolProfiles: [
      {
        vmSize: 'Standard_DS2_v2'
        count: 1
        mode: 'System'
        name: 'default'
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

resource fluxConfiguration 'Microsoft.KubernetesConfiguration/fluxConfigurations@2022-03-01' = {
  name: resourceName
  scope: managedCluster
  dependsOn: [
    extension
  ]
  properties: {
    sourceKind: 'GitRepository'
    suspend: false
    gitRepository: {
      syncIntervalInSeconds: 120
      timeoutInSeconds: 120
      url: 'https://github.com/Azure/arc-k8s-demo'
      repositoryRef: {
        branch: 'branch'
      }
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
  }
}
