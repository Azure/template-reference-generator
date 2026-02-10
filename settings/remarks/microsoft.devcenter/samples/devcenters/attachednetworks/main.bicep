param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource devCenter 'Microsoft.DevCenter/devcenters@2023-04-01' = {
  name: resourceName
  location: location
  identity: {
    type: 'SystemAssigned'
    userAssignedIdentities: null
  }
}

resource networkConnection 'Microsoft.DevCenter/networkConnections@2023-04-01' = {
  name: resourceName
  properties: {
    domainJoinType: 'AzureADJoin'
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
  }
}

resource attachNetwork 'Microsoft.DevCenter/devcenters/attachednetworks@2023-04-01' = {
  name: resourceName
  parent: devCenter
  properties: {
    networkConnectionId: networkConnection.id
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
  }
}
