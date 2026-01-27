param resourceName string = 'acctest0001'
param location string = 'westus'

resource netAppAccount 'Microsoft.NetApp/netAppAccounts@2025-01-01' = {
  name: '${resourceName}-acct'
  location: location
  properties: {}
}

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
    addressSpace: {
      addressPrefixes: [
        '10.88.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource capacityPool 'Microsoft.NetApp/netAppAccounts/capacityPools@2025-01-01' = {
  parent: netAppAccount
  name: '${resourceName}-pool'
  location: location
  properties: {
    coolAccess: false
    encryptionType: 'Single'
    qosType: 'Auto'
    serviceLevel: 'Standard'
    size: 4398046511104
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: '${resourceName}-subnet'
  properties: {
    addressPrefix: '10.88.2.0/24'
    defaultOutboundAccess: true
    delegations: [
      {
        name: 'netapp-delegation'
        properties: {
          serviceName: 'Microsoft.NetApp/volumes'
        }
      }
    ]
    networkSecurityGroup: {
      id: networkSecurityGroup.id
    }
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource volume 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes@2025-01-01' = {
  parent: capacityPool
  name: '${resourceName}-vol'
  location: location
  properties: {
    creationToken: 'acctest0001-path'
    dataProtection: {}
    exportPolicy: {
      rules: []
    }
    protocolTypes: [
      'NFSv3'
    ]
    serviceLevel: 'Standard'
    subnetId: subnet.id
    usageThreshold: 107374182400
  }
}

resource volumeQuotaRule 'Microsoft.NetApp/netAppAccounts/capacityPools/volumes/volumeQuotaRules@2025-01-01' = {
  parent: volume
  name: '${resourceName}-quota'
  location: location
  properties: {
    quotaSizeInKiBs: 2048
    quotaType: 'DefaultGroupQuota'
  }
}
