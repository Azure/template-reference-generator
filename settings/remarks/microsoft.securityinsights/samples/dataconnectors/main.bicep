param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource dataConnector 'Microsoft.SecurityInsights/dataConnectors@2022-10-01-preview' = {
  scope: workspace
  name: resourceName
  kind: 'MicrosoftThreatIntelligence'
  properties: {
    dataTypes: {
      bingSafetyPhishingURL: {
        lookbackPeriod: ''
        state: 'Disabled'
      }
      microsoftEmergingThreatFeed: {
        lookbackPeriod: '1970-01-01T00:00:00Z'
        state: 'enabled'
      }
    }
    tenantId: deployer().tenantId
  }
  dependsOn: [
    onboardingState
  ]
}

resource onboardingState 'Microsoft.SecurityInsights/onboardingStates@2023-06-01-preview' = {
  scope: workspace
  name: 'default'
  properties: {
    customerManagedKey: false
  }
}

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
