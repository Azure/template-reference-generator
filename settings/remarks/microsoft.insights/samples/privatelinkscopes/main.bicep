param resourceName string = 'acctest0001'

resource privateLinkScope 'Microsoft.Insights/privateLinkScopes@2019-10-17-preview' = {
  name: resourceName
  properties: {}
}
