param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource diagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: vault
  name: resourceName
  properties: {
    eventHubAuthorizationRuleId: authorizationRule.id
    eventHubName: namespace.name
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

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    capacity: 1
    name: 'Basic'
    tier: 'Basic'
  }
}

resource vault 'Microsoft.KeyVault/vaults@2021-10-01' = {
  name: resourceName
  location: location
  properties: {
    accessPolicies: []
    createMode: 'default'
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

resource authorizationRule 'Microsoft.EventHub/namespaces/authorizationRules@2021-11-01' = {
  parent: namespace
  name: 'example'
  properties: {
    rights: [
      'Listen'
      'Send'
      'Manage'
    ]
  }
}
