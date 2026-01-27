param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationGateway 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    authenticationCertificates: []
    backendAddressPools: [
      {
        name: '\'${virtualNetwork.name}-beap\''
        properties: {
          backendAddresses: []
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: '\'${virtualNetwork.name}-be-htst\''
        properties: {
          authenticationCertificates: []
          cookieBasedAffinity: 'Disabled'
          path: ''
          pickHostNameFromBackendAddress: false
          port: 80
          protocol: 'Http'
          requestTimeout: 1
          trustedRootCertificates: []
        }
      }
    ]
    customErrorConfigurations: []
    enableHttp2: false
    frontendIPConfigurations: [
      {
        name: '\'${virtualNetwork.name}-feip\''
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: '\'${virtualNetwork.name}-feport\''
        properties: {
          port: 80
        }
      }
    ]
    gatewayIPConfigurations: [
      {
        name: 'my-gateway-ip-configuration'
        properties: {
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
    httpListeners: [
      {
        name: '\'${virtualNetwork.name}-httplstn\''
        properties: {
          customErrorConfigurations: []
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              resourceName,
              '${virtualNetwork.name}-feip'
            )
          }
          frontendPort: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendPorts',
              resourceName,
              '${virtualNetwork.name}-feport'
            )
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
    ]
    privateLinkConfigurations: []
    probes: []
    redirectConfigurations: []
    requestRoutingRules: [
      {
        name: '${virtualNetwork.name}-rqrt'
        properties: {
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendAddressPools',
              resourceName,
              '${virtualNetwork.name}-beap'
            )
          }
          backendHttpSettings: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendHttpSettingsCollection',
              resourceName,
              '${virtualNetwork.name}-be-htst'
            )
          }
          httpListener: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/httpListeners',
              resourceName,
              '${virtualNetwork.name}-httplstn'
            )
          }
          priority: 10
          ruleType: 'Basic'
        }
      }
    ]
    rewriteRuleSets: []
    sku: {
      capacity: 2
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    sslCertificates: []
    sslPolicy: {}
    sslProfiles: []
    trustedClientCertificates: []
    trustedRootCertificates: []
    urlPathMaps: []
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
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

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  parent: virtualNetwork
  name: 'subnet-230630033653837171'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}
