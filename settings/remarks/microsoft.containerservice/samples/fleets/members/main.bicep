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
        enableEncryptionAtHost: false
        kubeletDiskType: ''
        mode: 'System'
        osDiskType: 'Managed'
        tags: {}
        type: 'VirtualMachineScaleSets'
        enableAutoScaling: false
        enableFIPS: false
        name: 'default'
        enableNodePublicIP: false
        nodeLabels: {}
        osType: 'Linux'
        scaleDownMode: 'Delete'
        count: 1
        enableUltraSSD: false
        upgradeSettings: {
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
          drainTimeoutInMinutes: 0
        }
        vmSize: 'Standard_B2s'
      }
    ]
    apiServerAccessProfile: {
      disableRunCommand: false
      enablePrivateCluster: false
      enablePrivateClusterPublicFQDN: false
    }
    disableLocalAccounts: false
    dnsPrefix: '${resourceName}'
    enableRBAC: true
    kubernetesVersion: ''
    servicePrincipalProfile: {
      clientId: 'msi'
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
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeResourceGroup: ''
    securityProfile: {}
    supportPlan: 'KubernetesOfficial'
    addonProfiles: {}
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
