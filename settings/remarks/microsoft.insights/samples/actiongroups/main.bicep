param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    emailReceivers: []
    itsmReceivers: []
    logicAppReceivers: []
    voiceReceivers: []
    automationRunbookReceivers: []
    enabled: true
    eventHubReceivers: []
    groupShortName: 'acctestag'
    smsReceivers: []
    webhookReceivers: []
    armRoleReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
  }
}
