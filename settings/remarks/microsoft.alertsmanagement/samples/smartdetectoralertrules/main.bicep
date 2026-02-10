param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    emailReceivers: []
    enabled: true
    groupShortName: 'acctestag'
    itsmReceivers: []
    logicAppReceivers: []
    voiceReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    automationRunbookReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    eventHubReceivers: []
    smsReceivers: []
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    DisableLocalAuth: false
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
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
      customWebhookPayload: ''
      groupIds: [
        actionGroup.id
      ]
      customEmailSubject: ''
    }
  }
}
