param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    ForceCustomerStorageForProfiler: false
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    DisableLocalAuth: false
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
  }
}

resource privateLinkScope 'Microsoft.Insights/privateLinkScopes@2019-10-17-preview' = {
  name: resourceName
  location: 'Global'
  properties: {}
}

resource scopedResource 'Microsoft.Insights/privateLinkScopes/scopedResources@2019-10-17-preview' = {
  name: resourceName
  parent: privateLinkScope
  properties: {
    linkedResourceId: component.id
  }
}
