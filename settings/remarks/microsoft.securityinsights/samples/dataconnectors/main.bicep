param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
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

resource dataConnector 'Microsoft.SecurityInsights/dataConnectors@2022-10-01-preview' = {
  name: resourceName
  scope: workspace
  dependsOn: [
    onboardingState
  ]
  kind: 'MicrosoftThreatIntelligence'
  properties: {
    dataTypes: {
      bingSafetyPhishingURL: {
        state: 'Disabled'
        lookbackPeriod: ''
      }
      microsoftEmergingThreatFeed: {
        lookbackPeriod: '1970-01-01T00:00:00Z'
        state: 'enabled'
      }
    }
    tenantId: tenant()
  }
}
