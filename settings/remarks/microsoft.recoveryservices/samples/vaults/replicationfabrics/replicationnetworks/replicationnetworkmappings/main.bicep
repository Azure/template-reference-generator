param resourceName string = 'acctest0001'
param location string = 'westus'

resource vault 'Microsoft.RecoveryServices/vaults@2024-01-01' = {
  name: '${resourceName}-rsv'
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    redundancySettings: {
      crossRegionRestore: 'Disabled'
      standardTierStorageRedundancy: 'GeoRedundant'
    }
  }
  sku: {
    name: 'Standard'
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
  parent: vault
  name: '${resourceName}-fabric1'
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'westus'
    }
  }
}

resource replicationfabric1 'Microsoft.RecoveryServices/vaults/replicationFabrics@2024-04-01' = {
  parent: vault
  name: '${resourceName}-fabric2'
  properties: {
    customDetails: {
      instanceType: 'Azure'
      location: 'centralus'
    }
  }
}

// The replication network is an intermediate resource under the replication fabric
resource replicationNetwork 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationNetworks@2024-04-01' existing = {
  parent: replicationFabric
  name: virtualNetwork.name
}

resource replicationNetworkMapping 'Microsoft.RecoveryServices/vaults/replicationFabrics/replicationNetworks/replicationNetworkMappings@2024-04-01' = {
  parent: replicationNetwork
  name: '${resourceName}-mapping'
  properties: {
    fabricSpecificDetails: {
      instanceType: 'AzureToAzure'
      primaryNetworkId: virtualNetwork.id
    }
    recoveryFabricName: replicationfabric1.name
    recoveryNetworkId: virtualnetwork1.id
  }
}
