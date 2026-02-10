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
  name: resourceName
  parent: networkManager
  properties: {}
}

resource securityAdminConfiguration 'Microsoft.Network/networkManagers/securityAdminConfigurations@2022-09-01' = {
  name: resourceName
  parent: networkManager
  properties: {
    applyOnNetworkIntentPolicyBasedServices: []
  }
}

resource ruleCollection 'Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections@2022-09-01' = {
  name: resourceName
  parent: securityAdminConfiguration
  properties: {
    appliesToGroups: [
      {
        networkGroupId: networkGroup.id
      }
    ]
  }
}

resource rule 'Microsoft.Network/networkManagers/securityAdminConfigurations/ruleCollections/rules@2022-09-01' = {
  name: resourceName
  parent: ruleCollection
  kind: 'Custom'
  properties: {
    destinationPortRanges: []
    destinations: []
    direction: 'Outbound'
    priority: 1
    sourcePortRanges: []
    protocol: 'Tcp'
    sources: []
    access: 'Deny'
  }
}
