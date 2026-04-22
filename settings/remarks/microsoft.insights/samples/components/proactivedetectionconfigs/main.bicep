param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    RetentionInDays: 90
    Application_Type: 'web'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
  }
}

resource proactiveDetectionConfig 'Microsoft.Insights/components/ProactiveDetectionConfigs@2015-05-01' = {
  name: 'slowpageloadtime'
  parent: component
}
