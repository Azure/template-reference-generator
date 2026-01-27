param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrative password for the Qumulo file system')
param qumuloPassword string

resource qumuloFileSystem 'Qumulo.Storage/fileSystems@2024-06-19' = {
  name: resourceName
  location: location
  properties: {
    adminPassword: null
    availabilityZone: '1'
    delegatedSubnetId: subnet.id
    marketplaceDetails: {
      offerId: 'qumulo-saas-mpp'
      planId: 'azure-native-qumulo-v3'
      publisherId: 'qumulo1584033880660'
    }
    storageSku: 'Cold_LRS'
    userDetails: {
      email: 'test@test.com'
    }
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: vnet
  name: resourceName
  location: location
  properties: {
    addressPrefix: '10.0.1.0/24'
    defaultOutboundAccess: true
    delegations: [
      {
        name: 'delegation'
        properties: {
          actions: [
            'Microsoft.Network/virtualNetworks/subnets/join/action'
          ]
          serviceName: 'Qumulo.Storage/fileSystems'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}
