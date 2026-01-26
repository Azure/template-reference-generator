param resourceName string = 'acctest0001'
param location string = 'westus'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-${resourceName}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource managedCluster 'Microsoft.ContainerService/managedClusters@2025-02-01' = {
  name: 'aks-${resourceName}'
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
    dnsPrefix: 'aks-acctest0001'
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

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'st${resourceName}'
  location: location
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: 'kv${resourceName}'
  location: location
  properties: {
    accessPolicies: []
    createMode: 'default'
    enableRbacAuthorization: false
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    softDeleteRetentionInDays: 7
    tenantId: deployer().tenantId
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: 'mlw-${resourceName}'
  location: location
  kind: 'Default'
  properties: {
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
  }
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
}

resource trustedAccessRoleBinding 'Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings@2025-02-01' = {
  parent: managedCluster
  name: 'tarb-${resourceName}'
  properties: {
    roles: [
      'Microsoft.MachineLearningServices/workspaces/mlworkload'
    ]
    sourceResourceId: workspace.id
  }
}
