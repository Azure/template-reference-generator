param resourceName string = 'acctest0001'
param location string = 'westus'

resource managedCluster 'Microsoft.ContainerService/managedClusters@2025-02-01' = {
  name: 'aks-${resourceName}'
  location: location
  sku: {
    name: 'Base'
    tier: 'Free'
  }
  properties: {
    securityProfile: {}
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    addonProfiles: {}
    agentPoolProfiles: [
      {
        enableFIPS: false
        enableUltraSSD: false
        mode: 'System'
        scaleDownMode: 'Delete'
        tags: {}
        type: 'VirtualMachineScaleSets'
        upgradeSettings: {
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
        }
        name: 'default'
        vmSize: 'Standard_B2s'
        enableEncryptionAtHost: false
        enableNodePublicIP: false
        osType: 'Linux'
        count: 1
        enableAutoScaling: false
        kubeletDiskType: ''
        nodeLabels: {}
        osDiskType: 'Managed'
      }
    ]
    autoUpgradeProfile: {
      nodeOSUpgradeChannel: 'NodeImage'
      upgradeChannel: 'none'
    }
    azureMonitorProfile: {
      metrics: {
        enabled: false
      }
    }
    kubernetesVersion: ''
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    supportPlan: 'KubernetesOfficial'
    apiServerAccessProfile: {
      enablePrivateClusterPublicFQDN: false
      disableRunCommand: false
      enablePrivateCluster: false
    }
    disableLocalAccounts: false
    dnsPrefix: 'aks-${resourceName}'
    enableRBAC: true
    nodeResourceGroup: ''
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'st${resourceName}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    isSftpEnabled: false
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
    isNfsV3Enabled: false
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
    isLocalUserEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    accessTier: 'Hot'
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
    softDeleteRetentionInDays: 7
    tenantId: tenant()
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: 'mlw-${resourceName}'
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  kind: 'Default'
  properties: {
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
  }
}

resource trustedAccessRoleBinding 'Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings@2025-02-01' = {
  name: 'tarb-${resourceName}'
  parent: managedCluster
  properties: {
    roles: [
      'Microsoft.MachineLearningServices/workspaces/mlworkload'
    ]
    sourceResourceId: workspace.id
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-${resourceName}'
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    SamplingPercentage: 100
  }
}
