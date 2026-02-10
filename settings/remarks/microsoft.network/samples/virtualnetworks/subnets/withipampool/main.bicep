param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: []
    networkManagerScopes: {
      subscriptions: [
        '/subscriptions/${subscription()}'
      ]
      managementGroups: []
    }
  }
}

resource ipamPool 'Microsoft.Network/networkManagers/ipamPools@2024-05-01' = {
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

resource vnetWithipam 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      ipamPoolPrefixAllocations: [
        {
          pool: {}
          numberOfIpAddresses: '100'
        }
      ]
    }
  }
}

resource subnetWithipam 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: resourceName
  parent: vnetWithipam
  properties: {
    ipamPoolPrefixAllocations: [
      {
        numberOfIpAddresses: '100'
        pool: {
          id: ipamPool.id
        }
      }
    ]
  }
}
