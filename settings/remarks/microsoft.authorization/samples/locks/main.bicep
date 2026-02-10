param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 30
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource lock 'Microsoft.Authorization/locks@2020-05-01' = {
  name: resourceName
  scope: publicIPAddress
  properties: {
    level: 'CanNotDelete'
    notes: ''
  }
}
