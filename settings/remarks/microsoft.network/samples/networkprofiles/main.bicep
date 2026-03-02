param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
              properties: {
                subnet: {}
              }
              name: 'acctestipconfig-230630033653886950'
            }
          ]
        }
      }
    ]
  }
}

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
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.1.0.0/24'
    delegations: [
      {
        name: 'acctestdelegation-230630033653886950'
        properties: {
          serviceName: 'Microsoft.ContainerInstance/containerGroups'
        }
      }
    ]
  }
}
