param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2024-10-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: [
      'Routing'
    ]
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        subscription().id
      ]
    }
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2024-10-01' = {
  parent: networkManager
  name: resourceName
  properties: {
    description: 'example network group'
    memberType: 'VirtualNetwork'
  }
}
