param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
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
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource savedSearch 'Microsoft.OperationalInsights/workspaces/savedSearches@2020-08-01' = {
  name: resourceName
  parent: workspace
  properties: {
    functionAlias: ''
    query: 'Heartbeat | summarize Count() by Computer | take a'
    tags: []
    category: 'Saved Search Test Category'
    displayName: 'Create or Update Saved Search Test'
  }
}
