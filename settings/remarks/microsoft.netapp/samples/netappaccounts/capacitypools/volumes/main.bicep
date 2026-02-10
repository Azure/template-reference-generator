param resourceName string = 'acctest0001'
param location string = 'centralus'

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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.6.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: 'GatewaySubnet'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.6.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.6.2.0/24'
    delegations: [
      {
        properties: {
          serviceName: 'Microsoft.Netapp/volumes'
        }
        name: 'testdelegation'
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
    serviceLevel: 'Standard'
    snapshotDirectoryVisible: true
    subnetId: subnet2.id
    volumeType: ''
    avsDataStore: 'Enabled'
    creationToken: 'my-unique-file-path-230630034120103726'
    usageThreshold: any('1.073741824e+11')
    dataProtection: {}
    exportPolicy: {
      rules: [
        {
          allowedClients: '0.0.0.0/0'
          nfsv3: true
          nfsv41: false
          ruleIndex: 1
          unixReadOnly: false
          cifs: false
          hasRootAccess: true
          unixReadWrite: true
        }
      ]
    }
    networkFeatures: 'Basic'
    protocolTypes: [
      'NFSv3'
    ]
  }
  tags: {
    SkipASMAzSecPack: 'true'
  }
}
