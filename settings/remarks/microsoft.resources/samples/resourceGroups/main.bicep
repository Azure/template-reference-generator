targetScope = 'subscription'

param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}
