param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
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
    publicNetworkAccessForIngestion: 'Enabled'
  }
}

resource savedSearch 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  name: resourceName
  parent: workspace
  properties: {
    query: 'Heartbeat | summarize Count() by Computer | take a'
    tags: []
    category: 'Saved Search Test Category'
    displayName: 'Create or Update Saved Search Test'
    functionAlias: ''
  }
}
