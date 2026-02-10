param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
    RetentionInDays: 90
  }
}
