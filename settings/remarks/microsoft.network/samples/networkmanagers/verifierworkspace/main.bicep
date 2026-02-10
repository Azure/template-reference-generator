param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    networkManagerScopeAccesses: [
      'SecurityAdmin'
    ]
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        '/subscriptions/${subscription().subscriptionId}'
      ]
    }
    description: ''
  }
}

resource verifierWorkspace 'Microsoft.Network/networkManagers/verifierWorkspaces@2024-01-01-preview' = {
  name: resourceName
  location: location
  parent: networkManager
  properties: {
    description: 'A sample workspace'
  }
}
