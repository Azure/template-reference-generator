param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    networkManagerScopeAccesses: [
      'SecurityAdmin'
    ]
    networkManagerScopes: {
      subscriptions: [
        subscription().id
      ]
      managementGroups: []
    }
    description: ''
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
