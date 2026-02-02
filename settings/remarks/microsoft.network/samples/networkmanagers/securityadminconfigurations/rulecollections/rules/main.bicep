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
        subscription().id
      ]
    }
  }
}

resource networkGroup 'Microsoft.Network/networkManagers/networkGroups@2022-09-01' = {
  parent: networkManager
  name: resourceName
  properties: {}
}

resource securityAdminConfiguration 'Microsoft.Network/networkManagers/securityAdminConfigurations@2022-09-01' = {
  parent: networkManager
  name: resourceName
  properties: {
    applyOnNetworkIntentPolicyBasedServices: []
  }
}

resource ruleCollection 'Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections@2022-09-01' = {
  parent: securityAdminConfiguration
  name: resourceName
  properties: {
    appliesToGroups: [
      {
        networkGroupId: networkGroup.id
      }
    ]
  }
}

resource rule 'Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2022-09-01' = {
  parent: ruleCollection
  name: resourceName
  kind: 'Custom'
  properties: {
    access: 'Deny'
    destinationPortRanges: []
    destinations: []
    direction: 'Outbound'
    priority: 1
    protocol: 'Tcp'
    sourcePortRanges: []
    sources: []
  }
}
