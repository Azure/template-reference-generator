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
    tactics: []
    techniques: []
    enabled: true
    severity: 'High'
    suppressionEnabled: false
    description: ''
    displayName: 'Some Rule'
    query: '''AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
'''
    suppressionDuration: 'PT5H'
  }
}

resource metadata 'Microsoft.SecurityInsights/metadata@2022-10-01-preview' = {
  name: resourceName
  scope: workspace
  properties: {
    contentId: resourceName
    contentSchemaVersion: '2.0'
    kind: 'AnalyticsRule'
    parentId: alertRule.id
  }
}
