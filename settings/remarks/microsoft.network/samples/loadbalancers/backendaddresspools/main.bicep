param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource loadBalancer 'Microsoft.Network/loadBalancers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    frontendIPConfigurations: [
      {
        name: 'internal'
        properties: {
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource backendAddressPool 'Microsoft.Network/loadBalancers/backendAddressPools@2022-07-01' = {
  parent: loadBalancer
  name: resourceName
  properties: {}
}
