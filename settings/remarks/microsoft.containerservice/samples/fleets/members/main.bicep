param location string = 'westus'
param resourceName string = 'acctest0001'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2025-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Base'
    tier: 'Free'
  }
  properties: {
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeResourceGroup: ''
    addonProfiles: {}
    agentPoolProfiles: [
      {
        mode: 'System'
        osDiskType: 'Managed'
        tags: {}
        count: 1
        enableAutoScaling: false
        enableUltraSSD: false
        scaleDownMode: 'Delete'
        vmSize: 'Standard_B2s'
        enableNodePublicIP: false
        type: 'VirtualMachineScaleSets'
        upgradeSettings: {
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
        }
        enableEncryptionAtHost: false
        name: 'default'
        nodeLabels: {}
        osType: 'Linux'
        enableFIPS: false
        kubeletDiskType: ''
      }
    ]
    enableRBAC: true
    securityProfile: {}
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    supportPlan: 'KubernetesOfficial'
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
    dnsPrefix: '${resourceName}'
    kubernetesVersion: ''
  }
}

resource fleet 'Microsoft.ContainerService/fleets@2024-04-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource member 'Microsoft.ContainerService/fleets/members@2024-04-01' = {
  name: resourceName
  parent: fleet
  properties: {
    group: 'default'
    clusterResourceId: managedCluster.id
  }
}
