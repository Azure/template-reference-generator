param resourceName string = 'acctest0001'
param location string = 'westus'

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
    name: 'Base'
    tier: 'Free'
  }
  properties: {
    supportPlan: 'KubernetesOfficial'
    agentPoolProfiles: [
      {
        nodeLabels: {}
        osType: 'Linux'
        scaleDownMode: 'Delete'
        vmSize: 'Standard_B2s'
        enableEncryptionAtHost: false
        enableUltraSSD: false
        upgradeSettings: {
          drainTimeoutInMinutes: 0
          maxSurge: '10%'
          nodeSoakDurationInMinutes: 0
        }
        mode: 'System'
        count: 1
        enableNodePublicIP: false
        name: 'default'
        osDiskType: 'Managed'
        tags: {}
        type: 'VirtualMachineScaleSets'
        enableAutoScaling: false
        enableFIPS: false
        kubeletDiskType: ''
      }
    ]
    autoUpgradeProfile: {
      nodeOSUpgradeChannel: 'NodeImage'
      upgradeChannel: 'none'
    }
    disableLocalAccounts: false
    dnsPrefix: 'aks-${resourceName}'
    enableRBAC: true
    kubernetesVersion: ''
    nodeResourceGroup: ''
    addonProfiles: {}
    apiServerAccessProfile: {
      enablePrivateClusterPublicFQDN: false
      disableRunCommand: false
      enablePrivateCluster: false
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
    securityProfile: {}
    servicePrincipalProfile: {
      clientId: 'msi'
    }
  }
}

resource trustedAccessRoleBinding 'Microsoft.ContainerService/managedClusters/trustedAccessRoleBindings@2025-02-01' = {
  name: 'tarb-${resourceName}'
  parent: managedCluster
  properties: {
    sourceResourceId: workspace.id
    roles: [
      'Microsoft.MachineLearningServices/workspaces/mlworkload'
    ]
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: 'ai-${resourceName}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForIngestion: 'Enabled'
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
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
    isNfsV3Enabled: false
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    dnsEndpointType: 'Standard'
    isSftpEnabled: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowSharedKeyAccess: true
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
    minimumTlsVersion: 'TLS1_2'
    allowCrossTenantReplication: false
    defaultToOAuthAuthentication: false
    isLocalUserEnabled: true
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: 'kv${resourceName}'
  location: location
  properties: {
    tenantId: tenant().tenantId
    enableRbacAuthorization: false
    enabledForDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    accessPolicies: []
    createMode: 'default'
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    softDeleteRetentionInDays: 7
  }
}
