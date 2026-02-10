targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'
param secondaryLocation string = 'centralus'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource resourcegroup1 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${resourceName}rg2'
  location: secondaryLocation
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourceGroup
  params: {
    secondaryLocation: secondaryLocation
    resourceName: resourceName
    location: location
  }
}
