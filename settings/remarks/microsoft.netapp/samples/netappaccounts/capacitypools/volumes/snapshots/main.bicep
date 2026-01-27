param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    activeDirectories: []
  }
}

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

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2022-05-01' = {
  parent: netAppAccount
  name: resourceName
  location: location
  properties: {
    serviceLevel: 'Premium'
    size: 4398046511104
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: resourceName
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: [
      {
        name: 'netapp'
        properties: {
          serviceName: 'Microsoft.Netapp/volumes'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource volume 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2022-05-01' = {
  parent: capacityPool
  name: resourceName
  location: location
  properties: {
    avsDataStore: 'Disabled'
    creationToken: 'my-unique-file-path-230630033642692134'
    dataProtection: {}
    exportPolicy: {
      rules: []
    }
    networkFeatures: 'Basic'
    protocolTypes: [
      'NFSv3'
    ]
    securityStyle: 'Unix'
    serviceLevel: 'Premium'
    snapshotDirectoryVisible: false
    snapshotId: ''
    subnetId: subnet.id
    usageThreshold: 107374182400
    volumeType: ''
  }
  zones: []
}

resource snapshot 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes/snapshots@2022-05-01' = {
  parent: volume
  name: resourceName
  location: location
}
