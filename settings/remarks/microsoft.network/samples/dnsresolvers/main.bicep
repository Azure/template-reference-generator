param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
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

resource dnsResolver 'Microsoft.Network/dnsResolvers@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    virtualNetwork: {}
  }
}
