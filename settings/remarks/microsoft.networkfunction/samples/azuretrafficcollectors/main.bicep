param resourceName string = 'acctest0001'
param location string = 'westus'

resource azureTrafficCollector 'Microsoft.NetworkFunction/azureTrafficCollectors@2022-11-01' = {
  name: resourceName
  location: location
  properties: {}
}
