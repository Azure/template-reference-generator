param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
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
    subnets: []
  }
}

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    activeDirectories: []
  }
}

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2022-05-01' = {
  name: resourceName
  location: location
  parent: netAppAccount
  properties: {
    serviceLevel: 'Premium'
    size: 4398046511104
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: [
      {
        properties: {
          serviceName: 'Microsoft.Netapp/volumes'
        }
        name: 'netapp'
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
  }
}

resource volume 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2022-05-01' = {
  name: resourceName
  location: location
  parent: capacityPool
  properties: {
    exportPolicy: {
      rules: []
    }
    networkFeatures: 'Basic'
    securityStyle: 'Unix'
    serviceLevel: 'Premium'
    subnetId: subnet.id
    usageThreshold: any('1.073741824e+11')
    volumeType: ''
    creationToken: 'my-unique-file-path-230630033642692134'
    dataProtection: {}
    protocolTypes: [
      'NFSv3'
    ]
    snapshotDirectoryVisible: false
    snapshotId: ''
    avsDataStore: 'Disabled'
  }
}

resource snapshot 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots@2022-05-01' = {
  name: resourceName
  location: location
  parent: volume
}
