param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource networkConnection 'Microsoft.DevCenter/networkConnections@2023-04-01' = {
  name: resourceName
  location: location
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
  }
}
