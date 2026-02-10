param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource bastionHost 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    enableTunneling: false
    ipConfigurations: [
      {
        name: 'ip-configuration'
        properties: {
          publicIPAddress: {}
          subnet: {}
        }
      }
    ]
    scaleUnits: 2
    disableCopyPaste: false
    enableFileCopy: false
    enableIpConnect: false
    enableShareableLink: false
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
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
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
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'AzureBastionSubnet'
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '192.168.1.224/27'
    delegations: []
  }
}
