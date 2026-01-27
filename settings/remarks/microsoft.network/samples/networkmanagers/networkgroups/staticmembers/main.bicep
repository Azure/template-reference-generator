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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-10-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/22'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2024-10-01' = {
  parent: networkManager
  name: resourceName
  properties: {}
}

resource networkGroupForSubnet 'Microsoft.Network/networkManagers/networkGroups@2024-10-01' = {
  parent: networkManager
  name: '${resourceName}-subnet'
  properties: {
    description: 'example network group'
    memberType: 'Subnet'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-10-01' = {
  parent: virtualNetwork
  name: resourceName
  properties: {
    addressPrefixes: [
      '10.0.0.0/24'
    ]
  }
}

resource staticMember 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01' = {
  parent: networkGroup
  name: resourceName
  properties: {
    resourceId: virtualNetwork.id
  }
}

resource staticMemberForSubnet 'Microsoft.Network/networkManagers/networkGroups/staticMembers@2024-10-01' = {
  parent: networkGroupForSubnet
  name: '${resourceName}-subnet'
  properties: {
    resourceId: subnet.id
  }
}
