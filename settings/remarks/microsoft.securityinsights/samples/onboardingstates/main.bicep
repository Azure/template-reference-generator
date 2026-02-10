param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
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
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource onboardingState 'Microsoft.SecurityInsights/onboardingStates@2022-11-01' = {
  name: 'default'
  scope: workspace
  properties: {
    customerManagedKey: false
  }
}
