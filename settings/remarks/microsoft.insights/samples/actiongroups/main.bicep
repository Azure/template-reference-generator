param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    armRoleReceivers: []
    automationRunbookReceivers: []
    azureAppPushReceivers: []
    eventHubReceivers: []
    groupShortName: 'acctestag'
    itsmReceivers: []
    logicAppReceivers: []
    webhookReceivers: []
    azureFunctionReceivers: []
    emailReceivers: []
    enabled: true
    smsReceivers: []
    voiceReceivers: []
  }
}
