param resourceName string = 'acctest0001'
param location string = 'westus'

var workspaceName = 'resourceName-mlw'
var outboundName = 'resourceName-outbound'
var baseName = 'resourcename'
var saBase = 'baseName'
var kvBase = 'baseName'
var storageName = 'sasaBase'
var keyVaultName = 'kvkvBase'
var aiName = 'resourceName-ai'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
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
    isHnsEnabled: false
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    dnsEndpointType: 'Standard'
    isLocalUserEnabled: true
    isSftpEnabled: false
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant()
    accessPolicies: []
    enablePurgeProtection: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2024-04-01' = {
  name: workspaceName
  location: location
  sku: {
    name: 'Basic'
  }
  kind: 'Default'
  properties: {
    managedNetwork: {
      isolationMode: 'AllowOnlyApprovedOutbound'
    }
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
    applicationInsights: component.id
    keyVault: vault.id
  }
}

resource outboundRule 'Microsoft.MachineLearningServices/workspaces/outboundRules@2024-04-01' = {
  name: outboundName
  parent: workspace
  properties: {
    category: 'UserDefined'
    destination: 'www.microsoft.com'
    type: 'FQDN'
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: aiName
  location: location
  kind: 'web'
  properties: {
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
  }
}
