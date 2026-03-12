param location string = 'westus'
param resourceName string = 'acctest0001'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}

resource amlFilesystem 'Microsoft.StorageCache/amlFilesystems@2024-07-01' = {
  name: '${resourceName}-amlfs'
  location: location
  sku: {
    name: 'AMLFS-Durable-Premium-250'
  }
  properties: {
    maintenanceWindow: {
      dayOfWeek: 'Friday'
      timeOfDayUTC: '22:00'
    }
    storageCapacityTiB: 8
  }
}
