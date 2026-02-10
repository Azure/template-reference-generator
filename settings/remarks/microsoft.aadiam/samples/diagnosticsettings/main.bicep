targetScope = 'tenant'

param resourceName string = 'acctest0001'
param location string = 'westus'

resource diagnosticSetting 'Microsoft.AADIAM/diagnosticSettings@2017-04-01' = {
  name: '${resourceName}-DS-unique'
  properties: {
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
        enabled: true
        category: 'B2CRequestLogs'
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
