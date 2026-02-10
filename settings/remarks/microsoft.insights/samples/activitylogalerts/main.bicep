param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    eventHubReceivers: []
    groupShortName: 'acctestag1'
    itsmReceivers: []
    smsReceivers: []
    voiceReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    automationRunbookReceivers: []
    emailReceivers: []
    enabled: true
    logicAppReceivers: []
  }
}

resource actionGroup2 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    webhookReceivers: []
    armRoleReceivers: []
    automationRunbookReceivers: []
    emailReceivers: []
    eventHubReceivers: []
    logicAppReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    enabled: true
    groupShortName: 'acctestag2'
    itsmReceivers: []
    smsReceivers: []
    voiceReceivers: []
  }
}

resource activityLogAlert 'Microsoft.Insights/activityLogAlerts@2020-10-01' = {
  name: resourceName
  location: 'global'
  properties: {
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
              field: 'properties.previousHealthStatus'
              equals: 'Available'
            }
          ]
        }
        {
          anyOf: [
            {
              equals: 'PlatformInitiated'
              field: 'properties.cause'
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
    enabled: true
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
    isNfsV3Enabled: false
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
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
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
  }
}
