param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    itsmReceivers: []
    smsReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    enabled: true
    groupShortName: 'acctestag1'
    logicAppReceivers: []
    voiceReceivers: []
    automationRunbookReceivers: []
    eventHubReceivers: []
  }
}

resource actionGroup2 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    armRoleReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    enabled: true
    eventHubReceivers: []
    smsReceivers: []
    voiceReceivers: []
    automationRunbookReceivers: []
    groupShortName: 'acctestag2'
    itsmReceivers: []
    logicAppReceivers: []
    webhookReceivers: []
  }
}

resource activityLogAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: resourceName
  location: 'global'
  properties: {
    enabled: true
    scopes: []
    actions: {
      actionGroups: [
        {
          actionGroupId: actionGroup.id
          webhookProperties: {}
        }
        {
          actionGroupId: actionGroup2.id
          webhookProperties: {
            from: 'terraform test'
            to: 'microsoft azure'
          }
        }
      ]
    }
    condition: {
      allOf: [
        {
          equals: 'ResourceHealth'
          field: 'category'
        }
        {
          anyOf: [
            {
              equals: 'Unavailable'
              field: 'properties.currentHealthStatus'
            }
            {
              equals: 'Degraded'
              field: 'properties.currentHealthStatus'
            }
          ]
        }
        {
          anyOf: [
            {
              equals: 'Unknown'
              field: 'properties.previousHealthStatus'
            }
            {
              equals: 'Available'
              field: 'properties.previousHealthStatus'
            }
          ]
        }
        {
          anyOf: [
            {
              field: 'properties.cause'
              equals: 'PlatformInitiated'
            }
            {
              equals: 'UserInitiated'
              field: 'properties.cause'
            }
          ]
        }
      ]
    }
    description: 'This is just a test acceptance.'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowCrossTenantReplication: true
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}
