param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource lock 'Microsoft.Authorization/locks@2020-05-01' = {
  scope: publicIPAddress
  name: resourceName
  properties: {
    level: 'CanNotDelete'
    notes: ''
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 30
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
}
