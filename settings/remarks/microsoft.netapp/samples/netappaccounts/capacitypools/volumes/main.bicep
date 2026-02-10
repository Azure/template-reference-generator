param resourceName string = 'acctest0001'
param location string = 'centralus'

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.6.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2022-05-01' = {
  name: resourceName
  location: location
  properties: {
    activeDirectories: []
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2022-05-01' = {
  name: resourceName
  location: location
  parent: netAppAccount
  properties: {
    serviceLevel: 'Standard'
    size: 4398046511104
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'GatewaySubnet'
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.6.1.0/24'
    delegations: []
  }
}

resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.6.2.0/24'
    delegations: [
      {
        name: 'testdelegation'
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
  name: resourceName
  location: location
  parent: capacityPool
  properties: {
    networkFeatures: 'Basic'
    snapshotDirectoryVisible: true
    usageThreshold: any('1.073741824e+11')
    volumeType: ''
    avsDataStore: 'Enabled'
    dataProtection: {}
    protocolTypes: [
      'NFSv3'
    ]
    serviceLevel: 'Standard'
    subnetId: subnet2.id
    creationToken: 'my-unique-file-path-230630034120103726'
    exportPolicy: {
      rules: [
        {
          cifs: false
          hasRootAccess: true
          nfsv41: false
          ruleIndex: 1
          unixReadOnly: false
          allowedClients: '0.0.0.0/0'
          nfsv3: true
          unixReadWrite: true
        }
      ]
    }
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}
