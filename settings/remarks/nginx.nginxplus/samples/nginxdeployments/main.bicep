param resourceName string = 'acctest0001'
param location string = 'westus'

resource nginxDeployment 'Nginx.NginxPlus/nginxDeployments@2024-11-01-preview' = {
  name: '${resourceName}-nginx'
  location: location
  properties: {
    autoUpgradeProfile: {
      upgradeChannel: 'stable'
    }
    enableDiagnosticsSupport: false
    networkProfile: {
      frontEndIPConfiguration: {
        publicIPAddresses: [
          {
            id: publicIPAddress.id
          }
        ]
      }
      networkInterfaceConfiguration: {
        subnetId: subnet.id
      }
    }
    scalingProperties: {
      autoScaleSettings: {
        profiles: [
          {
            capacity: {
              max: 30
              min: 10
            }
            name: 'test'
          }
        ]
      }
    }
    userProfile: {
      preferredEmail: 'test@test.com'
    }
  }
  sku: {
    name: 'standardv2_Monthly'
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip'
  location: location
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource publicipaddress1 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip2'
  location: location
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
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
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: '${resourceName}-subnet'
  properties: {
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
    delegations: [
      {
        name: 'delegation'
        properties: {
          serviceName: 'NGINX.NGINXPLUS/nginxDeployments'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent: virtualNetwork
  name: '${resourceName}-subnet2'
  properties: {
    addressPrefix: '10.0.3.0/24'
    defaultOutboundAccess: true
    delegations: [
      {
        name: 'delegation'
        properties: {
          serviceName: 'NGINX.NGINXPLUS/nginxDeployments'
        }
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
