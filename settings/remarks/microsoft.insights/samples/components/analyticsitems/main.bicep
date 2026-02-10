param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableLocalAuth: false
    SamplingPercentage: 100
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
  }
}

resource analyticsItem 'microsoft.insights/components/analyticsItems@2015-05-01' = {
  name: 'item'
  parent: component
}
