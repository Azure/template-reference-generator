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
  properties: {
    addonProfiles: {}
    agentPoolProfiles: [
      {
        count: 1
        enableAutoScaling: false
        enableEncryptionAtHost: false
        enableFIPS: false
        enableNodePublicIP: false
        enableUltraSSD: false
        kubeletDiskType: ''
        mode: 'System'
        name: 'default'
        nodeLabels: {}
        osDiskType: 'Managed'
        osType: 'Linux'
        scaleDownMode: 'Delete'
        tags: {}
        type: 'VirtualMachineScaleSets'
        upgradeSettings: {
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
        }
        vmSize: 'Standard_B2s'
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
    dnsPrefix: 'acctest0001'
    enableRBAC: true
    kubernetesVersion: ''
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeResourceGroup: ''
    securityProfile: {}
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    supportPlan: 'KubernetesOfficial'
  }
  sku: {
    name: 'Base'
    tier: 'Free'
  }
}

resource member 'Microsoft.ContainerService/fleets/members@2024-04-01' = {
  parent: fleet
  name: resourceName
  properties: {
    clusterResourceId: managedCluster.id
    group: 'default'
  }
}
