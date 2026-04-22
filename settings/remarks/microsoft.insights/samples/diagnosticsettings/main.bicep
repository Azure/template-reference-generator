param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Basic'
    tier: 'Basic'
  }
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: []
    createMode: 'default'
    enableSoftDelete: true
    enabledForDeployment: false
    enabledForDiskEncryption: false
    publicNetworkAccess: 'Enabled'
    sku: {
      name: 'standard'
      family: 'A'
    }
    tenantId: tenant().tenantId
    enableRbacAuthorization: false
    enabledForTemplateDeployment: false
  }
}

resource authorizationRule 'Microsoft.EventHub/namespaces/authorizationRules@2021-11-01' = {
  name: 'example'
  parent: namespace
  properties: {
    rights: [
      'Listen'
      'Send'
      'Manage'
    ]
  }
}

resource diagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: resourceName
  scope: vault
  properties: {
    logs: [
      {
        categoryGroup: 'Audit'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
        retentionPolicy: {
          days: 0
          enabled: false
        }
      }
    ]
  }
}
