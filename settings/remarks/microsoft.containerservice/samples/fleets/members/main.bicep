param resourceName string = 'acctest0001'
param location string = 'westus'

resource fleet 'Microsoft.ContainerService/fleets@2024-04-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource managedCluster 'Microsoft.ContainerService/managedClusters@2025-02-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'Free'
    name: 'Base'
  }
  properties: {
    agentPoolProfiles: [
      {
        kubeletDiskType: ''
        osDiskType: 'Managed'
        osType: 'Linux'
        count: 1
        enableAutoScaling: false
        enableEncryptionAtHost: false
        enableUltraSSD: false
        scaleDownMode: 'Delete'
        tags: {}
        upgradeSettings: {
          nodeSoakDurationInMinutes: 0
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
        }
        enableFIPS: false
        nodeLabels: {}
        type: 'VirtualMachineScaleSets'
        vmSize: 'Standard_B2s'
        enableNodePublicIP: false
        mode: 'System'
        name: 'default'
      }
    ]
    apiServerAccessProfile: {
      disableRunCommand: false
      enablePrivateCluster: false
      enablePrivateClusterPublicFQDN: false
    }
    autoUpgradeProfile: {
      nodeOSUpgradeChannel: 'NodeImage'
      upgradeChannel: 'none'
    }
    azureMonitorProfile: {
      metrics: {
        enabled: false
      }
    }
    disableLocalAccounts: false
    enableRBAC: true
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeResourceGroup: ''
    addonProfiles: {}
    dnsPrefix: '${resourceName}'
    kubernetesVersion: ''
    securityProfile: {}
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    supportPlan: 'KubernetesOfficial'
  }
}

resource member 'Microsoft.ContainerService/fleets/members@2024-04-01' = {
  name: resourceName
  parent: fleet
  properties: {
    clusterResourceId: managedCluster.id
    group: 'default'
  }
}
