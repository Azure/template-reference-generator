param resourceName string = 'acctest0001'
param location string = 'westus'

var keyVaultName = 'kvkvBase'
var outboundName = 'resourceName-outbound'
var baseName = 'resourcename'
var aiName = 'resourceName-ai'
var workspaceName = 'resourceName-mlw'
var saBase = 'baseName'
var kvBase = 'baseName'
var storageName = 'sasaBase'

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
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
    isLocalUserEnabled: true
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
    minimumTlsVersion: 'TLS1_2'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: true
    publicNetworkAccess: 'Enabled'
    tenantId: tenant().tenantId
    accessPolicies: []
    createMode: 'default'
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
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
    keyVault: vault.id
    managedNetwork: {
      isolationMode: 'AllowOnlyApprovedOutbound'
    }
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
    v1LegacyMode: false
    applicationInsights: component.id
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
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    ForceCustomerStorageForProfiler: false
  }
}
