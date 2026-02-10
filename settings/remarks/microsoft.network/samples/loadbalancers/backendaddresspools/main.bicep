param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource loadBalancer 'Microsoft.Network/loadBalancers@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    frontendIPConfigurations: [
      {
        properties: {
          publicIPAddress: {}
        }
        name: 'internal'
      }
    ]
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
  }
}

resource backendAddressPool 'Microsoft.Network/loadBalancers/backendAddressPools@2022-07-01' = {
  name: resourceName
  parent: loadBalancer
  properties: {}
}
