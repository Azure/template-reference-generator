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

resource connectivityConfiguration 'Microsoft.Network/networkManagers/connectivityConfigurations@2022-09-01' = {
  name: resourceName
  parent: networkManager
  properties: {
    appliesToGroups: [
      {
        groupConnectivity: 'None'
        isGlobal: 'False'
        useHubGateway: 'False'
      }
    ]
    connectivityTopology: 'HubAndSpoke'
    deleteExistingPeering: 'False'
    hubs: [
      {
        resourceId: virtualNetwork.id
        resourceType: virtualNetwork.type
      }
    ]
    isGlobal: 'False'
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2022-09-01' = {
  name: resourceName
  parent: networkManager
  properties: {}
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
