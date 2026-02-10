param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkManager 'Microsoft.Network/networkManagers@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    networkManagerScopes: {
      managementGroups: []
      subscriptions: [
        subscription().id
      ]
    }
    description: ''
    networkManagerScopeAccesses: [
      'SecurityAdmin'
    ]
  }
}

resource securityAdminConfiguration 'Microsoft.Network/networkManagers/securityAdminConfigurations@2022-09-01' = {
  name: resourceName
  parent: networkManager
  properties: {
    applyOnNetworkIntentPolicyBasedServices: []
  }
}
