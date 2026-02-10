param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
      disableLocalAuth: false
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
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

resource watchlist 'Microsoft.SecurityInsights/watchlists@2022-11-01' = {
  name: resourceName
  scope: workspace
  dependsOn: [
    onboardingState
  ]
  properties: {
    source: ''
    displayName: 'test'
    itemsSearchKey: 'k1'
    provider: 'Microsoft'
  }
}

resource watchlistItem 'Microsoft.SecurityInsights/watchlists/watchlistItems@2022-11-01' = {
  name: '196abd06-eb4e-4322-9c70-37c32e1a588a'
  parent: watchlist
  properties: {
    itemsKeyValue: {
      k1: 'v1'
    }
  }
}
