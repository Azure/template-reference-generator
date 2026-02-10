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
  properties: {}
}

resource networkGroupForSubnet 'Microsoft.Network/networkManagers/networkGroups@2024-10-01' = {
  name: '${resourceName}-subnet'
  parent: networkManager
  properties: {
    description: 'example network group'
    memberType: 'Subnet'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-10-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/22'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-10-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
  }
}

resource staticMember 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01' = {
  name: resourceName
  parent: networkGroup
  properties: {
    resourceId: virtualNetwork.id
  }
}

resource staticMemberForSubnet 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01' = {
  name: '${resourceName}-subnet'
  parent: networkGroupForSubnet
  properties: {
    resourceId: subnet.id
  }
}
