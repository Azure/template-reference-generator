targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource workspaceSetting 'Microsoft.Security/workspaceSettings@2017-08-01-preview' = {
  name: 'default'
  properties: {
    scope: '/subscriptions/${subscription()}'
    workspaceId: module1.outputs.workspaceId
  }
}

module module1 'main-rg-module.bicep' = {
  name: 'deploy-rg-resources'
  scope: resourceGroup
  params: {
    resourceName: resourceName
    location: location
  }
}
