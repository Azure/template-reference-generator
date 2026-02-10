param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource scheduledQueryRule 'Microsoft.Insights/scheduledQueryRules@2021-08-01' = {
  name: resourceName
  location: location
  kind: 'LogAlert'
  properties: {
    enabled: true
    evaluationFrequency: 'PT5M'
    targetResourceTypes: null
    scopes: [
      component.id
    ]
    severity: 3
    skipQueryValidation: false
    windowSize: 'PT5M'
    autoMitigate: false
    checkWorkspaceAlertsStorageConfigured: false
    criteria: {
      allOf: [
        {
          operator: 'Equal'
          query: ''' requests
| summarize CountByCountry=count() by client_CountryOrRegion
'''
          threshold: 5
          timeAggregation: 'Count'
          dimensions: null
        }
      ]
    }
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    Application_Type: 'web'
    DisableIpMasking: false
  }
}
