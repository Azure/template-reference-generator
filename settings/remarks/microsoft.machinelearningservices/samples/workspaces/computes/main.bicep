param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: []
    createMode: 'default'
    enableSoftDelete: true
    enabledForDeployment: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: tenant().tenantId
    enablePurgeProtection: true
    enableRbacAuthorization: false
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: false
    publicNetworkAccess: 'Enabled'
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2022-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    v1LegacyMode: false
    applicationInsights: component.id
    keyVault: vault.id
    publicNetworkAccess: 'Enabled'
    storageAccount: storageAccount.id
  }
}

resource compute 'Microsoft.MachineLearningServices/workspaces/computes@2022-05-01' = {
  name: resourceName
  location: location
  parent: workspace
  properties: {
    computeLocation: 'westeurope'
    computeType: 'ComputeInstance'
    description: ''
    disableLocalAuth: true
    properties: {
      vmSize: 'STANDARD_D2_V2'
    }
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForIngestion: 'Enabled'
    RetentionInDays: 90
    SamplingPercentage: 100
  }
}
