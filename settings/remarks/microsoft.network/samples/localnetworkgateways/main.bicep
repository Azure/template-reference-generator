param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource localNetworkGateway 'Microsoft.Network/localNetworkGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    gatewayIpAddress: '168.62.225.23'
    localNetworkAddressSpace: {
      addressPrefixes: [
        '10.1.1.0/24'
      ]
    }
  }
}
