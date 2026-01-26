param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
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

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
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
    tenantId: deployer().tenantId
  }
}

resource workspace 'Microsoft.MachineLearningServices/workspaces@2022-05-01' = {
  name: resourceName
  location: location
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

resource compute 'Microsoft.MachineLearningServices/workspaces/computes@2022-05-01' = {
  parent: workspace
  name: resourceName
  location: location
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
