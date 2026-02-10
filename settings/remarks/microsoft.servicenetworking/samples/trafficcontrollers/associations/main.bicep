param resourceName string = 'acctest0001'
param location string = 'westus'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.1.0/24'
    defaultOutboundAccess: true
    delegations: [
      {
        name: 'delegation'
        properties: {
          serviceName: 'Microsoft.ServiceNetworking/trafficControllers'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
  }
}

resource trafficController 'Microsoft.ServiceNetworking/trafficControllers@2023-11-01' = {
  name: '${resourceName}-tc'
  location: location
}

resource association 'Microsoft.ServiceNetworking/trafficControllers/associations@2023-11-01' = {
  name: '${resourceName}-assoc'
  location: location
  parent: trafficController
  properties: {
    associationType: 'subnets'
    subnet: {}
  }
}
