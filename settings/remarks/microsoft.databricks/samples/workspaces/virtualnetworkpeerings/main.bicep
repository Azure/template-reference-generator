param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.Databricks/workspaces@2023-02-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    managedResourceGroupId: resourceGroup().id
  }
}

resource virtualNetworkPeering 'Microsoft.Databricks/workspaces/virtualNetworkPeerings@2023-02-01' = {
  name: resourceName
  parent: workspace
  properties: {
    databricksAddressSpace: {
      addressPrefixes: [
        '10.139.0.0/16'
      ]
    }
    remoteAddressSpace: {
      addressPrefixes: [
        '10.0.1.0/24'
      ]
    }
    remoteVirtualNetwork: {
      id: virtualNetwork.id
    }
    useRemoteGateways: false
    allowForwardedTraffic: false
    allowGatewayTransit: false
    allowVirtualNetworkAccess: true
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.1.0/24'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}
