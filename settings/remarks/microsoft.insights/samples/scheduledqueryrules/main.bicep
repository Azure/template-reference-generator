param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
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
    enabled: true
    evaluationFrequency: 'PT5M'
    scopes: [
      component.id
    ]
    severity: 3
    skipQueryValidation: false
    targetResourceTypes: null
    windowSize: 'PT5M'
  }
}
