param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
              field: 'properties.currentHealthStatus'
              equals: 'Degraded'
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
              equals: 'PlatformInitiated'
              field: 'properties.cause'
            }
            {
              field: 'properties.cause'
              equals: 'UserInitiated'
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
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
  }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    azureAppPushReceivers: []
    emailReceivers: []
    eventHubReceivers: []
    groupShortName: 'acctestag1'
    itsmReceivers: []
    logicAppReceivers: []
    smsReceivers: []
    voiceReceivers: []
    armRoleReceivers: []
    automationRunbookReceivers: []
    azureFunctionReceivers: []
    enabled: true
    webhookReceivers: []
  }
}

resource actionGroup2 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    armRoleReceivers: []
    automationRunbookReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    eventHubReceivers: []
    smsReceivers: []
    voiceReceivers: []
    enabled: true
    groupShortName: 'acctestag2'
    itsmReceivers: []
    logicAppReceivers: []
    webhookReceivers: []
  }
}
