param resourceName string = 'acctest0001'
param location string = 'westus'

var kvBase = replace(baseName, '-', '')
var storageName = substring('sa${saBase}', 0, 24)
var keyVaultName = substring('kv${kvBase}', 0, 24)
var outboundName = '${resourceName}-outbound'
var workspaceName = '${resourceName}-mlw'
var baseName = toLower(resourceName)
var aiName = '${resourceName}-ai'
var saBase = replace(baseName, '-', '')

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

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: aiName
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

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
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
}

resource vault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    accessPolicies: []
    createMode: 'default'
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
  }
}
