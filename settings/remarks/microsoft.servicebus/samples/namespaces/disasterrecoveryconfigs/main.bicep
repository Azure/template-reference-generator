targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'
param secondaryLocation string = 'centralus'

resource resourcegroup1 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: '${resourceName}rg2'
  location: secondaryLocation
}

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourcegroup1
  params: {
    resourceName: resourceName
    location: location
    secondaryLocation: secondaryLocation
  }
}
