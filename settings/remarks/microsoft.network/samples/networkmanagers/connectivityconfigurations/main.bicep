param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    networkManagerScopeAccesses: [
      'SecurityAdmin'
      'Connectivity'
    ]
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        subscription().id
      ]
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    flowTimeoutInMinutes: 10
    subnets: []
  }
}

resource connectivityConfiguration 'Microsoft.Network/networkManagers/connectivityConfigurations@2022-09-01' = {
  parent: networkManager
  name: resourceName
  properties: {
    appliesToGroups: [
      {
        groupConnectivity: 'None'
        isGlobal: 'False'
        networkGroupId: networkGroup.id
        useHubGateway: 'False'
      }
    ]
    connectivityTopology: 'HubAndSpoke'
    deleteExistingPeering: 'False'
    hubs: [
      {
        resourceId: virtualNetwork.id
        resourceType: virtualNetwork.properties.type
      }
    ]
    isGlobal: 'False'
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2022-09-01' = {
  parent: networkManager
  name: resourceName
  properties: {}
}
