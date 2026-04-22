param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateLinkScope 'Microsoft.Insights/privateLinkScopes@2019-10-17-preview' = {
  name: resourceName
  location: 'Global'
  properties: {}
}
