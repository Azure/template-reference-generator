param location string = 'westeurope'
param resourceName string = 'acctest0001'

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

resource onboardingState 'Microsoft.SecurityInsights/onboardingStates@2022-11-01' = {
  name: 'default'
  scope: workspace
  properties: {
    customerManagedKey: false
  }
}
