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
    itemsSearchKey: 'k1'
    provider: 'Microsoft'
    source: ''
    displayName: 'test'
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
