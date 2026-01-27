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
      capacity: 10
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

resource configuration 'Nginx.NginxPlus/nginxDeployments/configurations@2024-11-01-preview' = {
  parent: nginxDeployment
  name: 'default'
  properties: {
    files: [
      {
        content: 'aHR0cCB7CiAgICBzZXJ2ZXIgewogICAgICAgIGxpc3RlbiA4MDsKICAgICAgICBsb2NhdGlvbiAvIHsKICAgICAgICAgICAgYXV0aF9iYXNpYyAiUHJvdGVjdGVkIEFyZWEiOwogICAgICAgICAgICBhdXRoX2Jhc2ljX3VzZXJfZmlsZSAvb3B0Ly5odHBhc3N3ZDsKICAgICAgICAgICAgZGVmYXVsdF90eXBlIHRleHQvaHRtbDsKICAgICAgICAgICAgcmV0dXJuIDIwMCAnPCFkb2N0eXBlIGh0bWw+PGh0bWwgbGFuZz0iZW4iPjxoZWFkPjwvaGVhZD48Ym9keT4KICAgICAgICAgICAgICAgIDxkaXY+dGhpcyBvbmUgd2lsbCBiZSB1cGRhdGVkPC9kaXY+CiAgICAgICAgICAgICAgICA8ZGl2PmF0IDEwOjM4IGFtPC9kaXY+CiAgICAgICAgICAgIDwvYm9keT48L2h0bWw+JzsKICAgICAgICB9CiAgICAgICAgaW5jbHVkZSBzaXRlLyouY29uZjsKICAgIH0KfQo='
        virtualPath: '/etc/nginx/nginx.conf'
      }
    ]
    protectedFiles: [
      {
        content: 'dXNlcjokYXByMSRWZVVBNWt0LiRJampSay8vOG1pUnhEc1p2RDRkYUYxCg=='
        virtualPath: '/opt/.htpasswd'
      }
    ]
    rootFile: '/etc/nginx/nginx.conf'
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
