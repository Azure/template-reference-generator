param resourceName string = 'acctest0001'
param location string = 'westus'

var baseName = 'resourcename'
var aiName = 'resourceName-ai'
var saBase = 'baseName'
var kvBase = 'baseName'
var storageName = 'sasaBase'
var keyVaultName = 'kvkvBase'
var outboundName = 'resourceName-outbound'
var workspaceName = 'resourceName-mlw'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: aiName
  location: location
  kind: 'web'
  properties: {
    SamplingPercentage: 100
    Application_Type: 'web'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowCrossTenantReplication: false
    encryption: {
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
      keySource: 'Microsoft.Storage'
    }
    isLocalUserEnabled: true
    networkAcls: {
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
    }
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
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
    accessPolicies: []
    enablePurgeProtection: true
    enabledForDiskEncryption: false
    tenantId: tenant().tenantId
    createMode: 'default'
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForTemplateDeployment: false
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
    applicationInsights: component.id
    keyVault: vault.id
    managedNetwork: {
      isolationMode: 'AllowOnlyApprovedOutbound'
    }
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
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
