param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    threatIntelMode: 'Alert'
  }
}

resource ruleCollectionGroup 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2022-07-01' = {
  name: resourceName
  parent: firewallPolicy
  properties: {
    priority: 500
    ruleCollections: []
  }
}
