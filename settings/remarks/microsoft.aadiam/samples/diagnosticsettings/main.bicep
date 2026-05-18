targetScope = 'tenant'

param resourceName string = 'acctest0001'
param location string = 'westus'

param subscriptionId string

resource diagnosticSetting 'Microsoft.AADIAM/diagnosticSettings@2017-04-01' = {
  name: '${resourceName}-DS-unique'
  properties: {
    eventHubAuthorizationRuleId: module1.outputs.authorizationRuleId
    eventHubName: module1.outputs.eventhubName
    logs: [
      {
        category: 'RiskyUsers'
        enabled: true
      }
      {
        category: 'ServicePrincipalSignInLogs'
        enabled: true
      }
      {
        category: 'SignInLogs'
        enabled: true
      }
      {
        category: 'B2CRequestLogs'
        enabled: true
      }
      {
        category: 'UserRiskEvents'
        enabled: true
      }
      {
        category: 'NonInteractiveUserSignInLogs'
        enabled: true
      }
      {
        category: 'AuditLogs'
        enabled: true
      }
    ]
  }
}

module module1 'main-subscription-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: subscription(subscriptionId)
  params: {
    resourceName: resourceName
    location: location
  }
}
