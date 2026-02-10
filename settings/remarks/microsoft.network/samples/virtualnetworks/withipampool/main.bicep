param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: []
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        '/subscriptions/${subscription().subscriptionId}'
      ]
    }
  }
}

resource vnetWithipam 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      ipamPoolPrefixAllocations: [
        {
          numberOfIpAddresses: '100'
          pool: {}
        }
      ]
    }
  }
}

resource ipamPool 'Microsoft.Network/networkManagers/ipamPools@2024-05-01' = {
  name: resourceName
  location: location
  parent: networkManager
  properties: {
    parentPoolName: ''
    addressPrefixes: [
      '10.0.0.0/24'
    ]
    description: 'Test description.'
    displayName: 'testDisplayName'
  }
}
