param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

resource onboardingState 'Microsoft.SecurityInsights/onboardingStates@2023-06-01-preview' = {
  name: 'default'
  scope: workspace
  properties: {
    customerManagedKey: false
  }
}

resource automationRule 'Microsoft.SecurityInsights/automationRules@2022-10-01-preview' = {
  name: '3b862818-ad7b-409e-83be-8812f2a06d37'
  scope: workspace
  dependsOn: [
    onboardingState
  ]
  properties: {
    actions: [
      {
        actionConfiguration: {
          classification: ''
          classificationComment: ''
          classificationReason: ''
          severity: ''
          status: 'Active'
        }
        actionType: 'ModifyProperties'
        order: 1
      }
    ]
    displayName: 'acctest-SentinelAutoRule-230630033910945846'
    order: 1
    triggeringLogic: {
      isEnabled: true
      triggersOn: 'Incidents'
      triggersWhen: 'Created'
    }
  }
}
