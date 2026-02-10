param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.1.0.0/24'
    delegations: [
      {
        name: 'acctestdelegation-230630033653886950'
        properties: {
          serviceName: 'Microsoft.ContainerInstance/containerGroups'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource networkProfile 'Microsoft.Network/networkProfiles@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    containerNetworkInterfaceConfigurations: [
      {
        name: 'acctesteth-230630033653886950'
        properties: {
          ipConfigurations: [
            {
              name: 'acctestipconfig-230630033653886950'
              properties: {
                subnet: {}
              }
            }
          ]
        }
      }
    ]
  }
}
