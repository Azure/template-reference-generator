param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    DisableLocalAuth: false
    publicNetworkAccessForIngestion: 'Enabled'
  }
}
