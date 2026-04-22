param resourceName string = 'acctest0001'
param location string = 'westus'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2024-05-01' = {
  name: '${resourceName}-nsg'
  location: location
  properties: {
    securityRules: []
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.88.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2025-01-01' = {
  name: '${resourceName}-acct'
  location: location
  properties: {}
}

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2025-01-01' = {
  name: '${resourceName}-pool'
  location: location
  parent: netAppAccount
  properties: {
    coolAccess: false
    encryptionType: 'Single'
    qosType: 'Auto'
    serviceLevel: 'Standard'
    size: 4398046511104
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Disabled'
    addressPrefix: '10.88.2.0/24'
    defaultOutboundAccess: true
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    delegations: [
      {
        name: 'netapp-delegation'
        properties: {
          serviceName: 'Microsoft.NetApp/volumes'
        }
      }
    ]
  }
}

resource volume 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2025-01-01' = {
  name: '${resourceName}-vol'
  location: location
  parent: capacityPool
  properties: {
    subnetId: subnet.id
    usageThreshold: any('1.073741824e+11')
    creationToken: '${resourceName}-path'
    dataProtection: {}
    exportPolicy: {
      rules: []
    }
    protocolTypes: [
      'NFSv3'
    ]
    serviceLevel: 'Standard'
  }
}

resource volumeQuotaRule 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes/volumeQuotaRules@2025-01-01' = {
  name: '${resourceName}-quota'
  location: location
  parent: volume
  properties: {
    quotaSizeInKiBs: 2048
    quotaType: 'DefaultGroupQuota'
  }
}
