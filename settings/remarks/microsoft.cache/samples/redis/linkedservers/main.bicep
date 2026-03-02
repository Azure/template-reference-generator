targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource resourcegroupSecondary 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${resourceName}-secondary'
  location: location
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourceGroup
  params: {
    resourceName: resourceName
    location: location
  }
}
