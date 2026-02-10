param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource networkManager 'Microsoft.Network/networkManagers@2024-10-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: [
      'Routing'
    ]
    networkManagerScopes: {
      subscriptions: [
        subscription().id
      ]
      managementGroups: []
    }
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2024-10-01' = {
  name: resourceName
  parent: networkManager
  properties: {
    memberType: 'VirtualNetwork'
    description: 'example network group'
  }
}
