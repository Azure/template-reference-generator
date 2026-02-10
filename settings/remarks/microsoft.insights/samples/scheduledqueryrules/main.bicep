param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
  }
}

resource scheduledQueryRule 'Microsoft.Insights/scheduledQueryRules@2021-08-01' = {
  name: resourceName
  location: location
  kind: 'LogAlert'
  properties: {
    autoMitigate: false
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
    severity: 3
    targetResourceTypes: null
    windowSize: 'PT5M'
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      component.id
    ]
    skipQueryValidation: false
  }
}
