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
        '/subscriptions/subscription().subscriptionId'
      ]
    }
  }
}

resource ipamPool 'Microsoft.Network/networkManagers/ipamPools@2024-01-01-preview' = {
  parent: networkManager
  name: resourceName
  location: location
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    description: 'Test description.'
    displayName: 'testDisplayName'
    parentPoolName: ''
  }
}

resource staticCidr 'Microsoft.Network/networkManagers/ipamPools/staticCidrs@2024-01-01-preview' = {
  parent: ipamPool
  name: resourceName
  properties: {
    addressPrefixes: [
      '10.0.0.0/25'
    ]
    description: 'test description'
    numberOfIPAddressesToAllocate: ''
  }
}
