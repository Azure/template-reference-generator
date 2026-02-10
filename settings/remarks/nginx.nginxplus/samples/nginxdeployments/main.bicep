param resourceName string = 'acctest0001'
param location string = 'westus'

resource publicipaddress1 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip2'
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

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
  location: location
  properties: {
    privateEndpointVNetPolicies: 'Disabled'
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet'
  parent: virtualNetwork
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
  name: '${resourceName}-subnet2'
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
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
  }
}

resource nginxDeployment 'Nginx.NginxPlus/nginxDeployments@2024-11-01-preview' = {
  name: '${resourceName}-nginx'
  location: location
  sku: {
    name: 'standardv2_Monthly'
  }
  properties: {
    autoUpgradeProfile: {
      upgradeChannel: 'stable'
    }
    enableDiagnosticsSupport: false
    networkProfile: {
      frontEndIPConfiguration: {
        publicIPAddresses: [
          {}
        ]
      }
      networkInterfaceConfiguration: {}
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
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}
