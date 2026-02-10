param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource scheduledQueryRule 'Microsoft.Insights/scheduledQueryRules@2021-08-01' = {
  name: resourceName
  location: location
  kind: 'LogAlert'
  properties: {
    checkWorkspaceAlertsStorageConfigured: false
    criteria: {
      allOf: [
        {
          dimensions: null
          operator: 'Equal'
          query: ''' requests
| summarize CountByCountry=count() by client_CountryOrRegion
'''
          threshold: 5
          timeAggregation: 'Count'
        }
      ]
    }
    evaluationFrequency: 'PT5M'
    scopes: [
      component.id
    ]
    severity: 3
    targetResourceTypes: null
    windowSize: 'PT5M'
    autoMitigate: false
    enabled: true
    skipQueryValidation: false
  }
}
