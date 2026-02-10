param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: [
      'SecurityAdmin'
    ]
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        '/subscriptions/${subscription()}'
      ]
    }
  }
}

resource ipamPool 'Microsoft.Network/networkManagers/ipamPools@2024-01-01-preview' = {
  name: resourceName
  location: location
  parent: networkManager
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    description: 'Test description.'
    displayName: 'testDisplayName'
    parentPoolName: ''
  }
}
