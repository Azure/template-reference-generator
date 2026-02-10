param resourceName string = 'acctest0001'
param location string = 'westus'

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
  name: '${resourceName}-subnet'
  parent: virtualNetwork
  properties: {
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
    addressPrefix: '10.0.2.0/24'
  }
}

resource subnet1 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: '${resourceName}-subnet2'
  parent: virtualNetwork
  properties: {
    defaultOutboundAccess: true
    delegations: [
      {
        properties: {
          serviceName: 'NGINX.NGINXPLUS/nginxDeployments'
        }
        name: 'delegation'
      }
    ]
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.3.0/24'
  }
}

resource nginxDeployment 'Nginx.NginxPlus/nginxDeployments@2024-11-01-preview' = {
  name: '${resourceName}-nginx'
  location: location
  sku: {
    name: 'standardv2_Monthly'
  }
  properties: {
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
              min: 10
              max: 30
            }
            name: 'test'
          }
        ]
      }
    }
    userProfile: {
      preferredEmail: 'test@test.com'
    }
    autoUpgradeProfile: {
      upgradeChannel: 'stable'
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
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
  }
}

resource publicipaddress1 'Microsoft.Network/publicIPAddresses@2024-05-01' = {
  name: '${resourceName}-pip2'
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
