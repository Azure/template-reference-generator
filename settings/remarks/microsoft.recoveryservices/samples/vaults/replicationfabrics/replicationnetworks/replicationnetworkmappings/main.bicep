param resourceName string = 'acctest0001'
param location string = 'westus'

resource vault 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: '${resourceName}-rsv'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    redundancySettings: {
      crossRegionRestore: 'Disabled'
      standardTierStorageRedundancy: 'GeoRedundant'
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet1'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.1.0/24'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource virtualnetwork1 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet2'
  location: 'centralus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '192.168.2.0/24'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource replicationFabric 'Microsoft.RecoveryServices/vaults/replicationFabrics@2024-04-01' = {
  name: '${resourceName}-fabric1'
  parent: vault
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: '${location}'
    }
  }
}

resource replicationfabric1 'Microsoft.RecoveryServices/vaults/replicationFabrics@2024-04-01' = {
  name: '${resourceName}-fabric2'
  parent: vault
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'centralus'
    }
  }
}

resource replicationNetworkMapping 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationNetworks/replicationNetworkMappings@2024-04-01' = {
  name: '${resourceName}-mapping'
  properties: {
    fabricSpecificDetails: {
      primaryNetworkId: virtualNetwork.id
      instanceType: 'AzureToAzure'
    }
    recoveryFabricName: replicationfabric1.name
    recoveryNetworkId: virtualnetwork1.id
  }
}
