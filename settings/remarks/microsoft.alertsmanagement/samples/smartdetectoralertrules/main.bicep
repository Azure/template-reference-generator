param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    logicAppReceivers: []
    smsReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    automationRunbookReceivers: []
    emailReceivers: []
    enabled: true
    eventHubReceivers: []
    groupShortName: 'acctestag'
    itsmReceivers: []
    voiceReceivers: []
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    SamplingPercentage: 100
    Application_Type: 'web'
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableLocalAuth: false
    RetentionInDays: 90
  }
}

resource smartDetectorAlertRule 'microsoft.alertsManagement/smartDetectorAlertRules@2019-06-01' = {
  name: resourceName
  location: 'global'
  properties: {
    description: ''
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    frequency: 'PT1M'
    scope: [
      component.id
    ]
    severity: 'Sev0'
    state: 'Enabled'
    actionGroups: {
      customEmailSubject: ''
      customWebhookPayload: ''
      groupIds: [
        actionGroup.id
      ]
    }
  }
}
