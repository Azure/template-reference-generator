targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource networkManagerConnection 'Microsoft.Network/networkManagerConnections@2022-09-01' = {
  name: resourceName
  properties: {
    networkManagerId: module1.outputs.networkManagerId
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
