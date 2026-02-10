param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource smartDetectorAlertRule 'microsoft.alertsManagement/smartDetectorAlertRules@2019-06-01' = {
  name: resourceName
  location: 'global'
  properties: {
    actionGroups: {
      customEmailSubject: ''
      customWebhookPayload: ''
      groupIds: [
        actionGroup.id
      ]
    }
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
  }
}

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    logicAppReceivers: []
    smsReceivers: []
    voiceReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    enabled: true
    eventHubReceivers: []
    groupShortName: 'acctestag'
    itsmReceivers: []
    automationRunbookReceivers: []
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
  }
}
