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

resource analyticsItem 'microsoft.insights/components/analyticsItems@2015-05-01' = {
  parent: component
  name: 'item'
  Content: 'requests #test'
  Name: 'testquery'
  Scope: 'shared'
  Type: 'query'
}
