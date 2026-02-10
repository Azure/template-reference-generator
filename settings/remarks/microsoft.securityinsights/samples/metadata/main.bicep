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

resource alertRule 'Microsoft.SecurityInsights/alertRules@2022-10-01-preview' = {
  name: resourceName
  scope: workspace
  dependsOn: [
    onboardingState
  ]
  kind: 'NRT'
  properties: {
    displayName: 'Some Rule'
    enabled: true
    suppressionDuration: 'PT5H'
    tactics: []
    description: ''
    query: '''AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
'''
    severity: 'High'
    suppressionEnabled: false
    techniques: []
  }
}

resource metadata 'Microsoft.SecurityInsights/metadata@2022-10-01-preview' = {
  name: resourceName
  scope: workspace
  properties: {
    parentId: alertRule.id
    contentId: resourceName
    contentSchemaVersion: '2.0'
    kind: 'AnalyticsRule'
  }
}
