param resourceName string = 'acctest0001'
param location string = 'westus'

resource amlFilesystem 'Microsoft.StorageCache/amlFilesystems@2024-07-01' = {
  name: '${resourceName}-amlfs'
  location: location
  properties: {
    filesystemSubnet: subnet.id
    maintenanceWindow: {
      dayOfWeek: 'Friday'
      timeOfDayUTC: '22:00'
    }
    storageCapacityTiB: 8
  }
  sku: {
    name: 'AMLFS-Durable-Premium-250'
  }
  zones: [
    '1'
  ]
}

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
  parent: virtualNetwork
  name: '${resourceName}-subnet'
  properties: {
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
