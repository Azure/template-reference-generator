param resourceName string = 'acctest0001'
param location string = 'westus'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'st${resourceName}'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: true
    isHnsEnabled: false
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
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
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: 'kv${resourceName}'
  location: location
  properties: {
    accessPolicies: []
    enabledForDeployment: false
    enabledForDiskEncryption: false
    publicNetworkAccess: 'Enabled'
    sku: {
      name: 'standard'
      family: 'A'
    }
    softDeleteRetentionInDays: 7
    createMode: 'default'
    enableRbacAuthorization: false
    enabledForTemplateDeployment: false
    tenantId: tenant().tenantId
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

resource managedCluster 'Microsoft.ContainerService/managedClusters@2025-02-01' = {
  name: 'aks-${resourceName}'
  location: location
  sku: {
    tier: 'Free'
    name: 'Base'
  }
  properties: {
    apiServerAccessProfile: {
      disableRunCommand: false
      enablePrivateCluster: false
      enablePrivateClusterPublicFQDN: false
    }
    azureMonitorProfile: {
      metrics: {
        enabled: false
      }
    }
    disableLocalAccounts: false
    dnsPrefix: 'aks-${resourceName}'
    enableRBAC: true
    metricsProfile: {
      costAnalysis: {
        enabled: false
      }
    }
    nodeResourceGroup: ''
    servicePrincipalProfile: {
      clientId: 'msi'
    }
    addonProfiles: {}
    agentPoolProfiles: [
      {
        enableAutoScaling: false
        name: 'default'
        nodeLabels: {}
        enableEncryptionAtHost: false
        osDiskType: 'Managed'
        tags: {}
        type: 'VirtualMachineScaleSets'
        upgradeSettings: {
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
        }
        scaleDownMode: 'Delete'
        count: 1
        enableNodePublicIP: false
        enableUltraSSD: false
        kubeletDiskType: ''
        osType: 'Linux'
        enableFIPS: false
        mode: 'System'
        vmSize: 'Standard_B2s'
      }
    ]
    autoUpgradeProfile: {
      nodeOSUpgradeChannel: 'NodeImage'
      upgradeChannel: 'none'
    }
    kubernetesVersion: ''
    securityProfile: {}
    supportPlan: 'KubernetesOfficial'
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
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
  }
}
