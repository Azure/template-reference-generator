param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource queryPack 'Microsoft.OperationalInsights/queryPacks@2019-09-01' = {
  name: resourceName
  location: location
  properties: {}
}
