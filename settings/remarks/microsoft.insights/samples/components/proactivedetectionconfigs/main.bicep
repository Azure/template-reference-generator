param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    RetentionInDays: 90
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    SamplingPercentage: 100
  }
}

resource proactiveDetectionConfig 'Microsoft.Insights/components/ProactiveDetectionConfigs@2015-05-01' = {
  name: 'slowpageloadtime'
  parent: component
}
