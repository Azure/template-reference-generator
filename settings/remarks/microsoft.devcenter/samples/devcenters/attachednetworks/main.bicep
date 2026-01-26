param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
  location: 'westeurope'
  properties: {
    domainJoinType: 'AzureADJoin'
    subnetId: subnet.id
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
  parent: devCenter
  name: resourceName
  properties: {
    networkConnectionId: networkConnection.id
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: resourceName
  properties: {
    addressPrefix: '10.0.2.0/24'
  }
}
