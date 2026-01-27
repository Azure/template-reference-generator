param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource alertRule 'Microsoft.SecurityInsights/alertRules@2022-10-01-preview' = {
  scope: workspace
  name: resourceName
  kind: 'NRT'
  properties: {
    description: ''
    displayName: 'Some Rule'
    enabled: true
    query: '''AzureActivity |
  where OperationName == "Create or Update Virtual Machine" or OperationName =="Create Deployment" |
  where ActivityStatus == "Succeeded" |
  make-series dcount(ResourceId) default=0 on EventSubmissionTimestamp in range(ago(7d), now(), 1d) by Caller
'''
    severity: 'High'
    suppressionDuration: 'PT5H'
    suppressionEnabled: false
    tactics: []
    techniques: []
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
