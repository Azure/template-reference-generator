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
      subscriptions: [
        '/subscriptions/${subscription().subscriptionId}'
      ]
      managementGroups: []
    }
  }
}

resource ipamPool 'Microsoft.Network/networkManagers/ipamPools@2024-01-01-preview' = {
  name: resourceName
  location: location
  parent: networkManager
  properties: {
    displayName: 'testDisplayName'
    parentPoolName: ''
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    description: 'Test description.'
  }
}

resource staticCidr 'Microsoft.Network/networkManagers/ipamPools/staticCidrs@2024-01-01-preview' = {
  name: resourceName
  parent: ipamPool
  properties: {
    numberOfIPAddressesToAllocate: ''
    addressPrefixes: [
      '10.0.0.0/25'
    ]
    description: 'test description'
  }
}
