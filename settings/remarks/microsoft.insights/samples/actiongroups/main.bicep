param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: resourceName
  location: 'global'
  properties: {
    emailReceivers: []
    enabled: true
    eventHubReceivers: []
    logicAppReceivers: []
    voiceReceivers: []
    webhookReceivers: []
    automationRunbookReceivers: []
    azureAppPushReceivers: []
    azureFunctionReceivers: []
    groupShortName: 'acctestag'
    itsmReceivers: []
    smsReceivers: []
    armRoleReceivers: []
  }
}
