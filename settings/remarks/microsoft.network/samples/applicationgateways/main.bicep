param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
  name: 'subnet-230630033653837171'
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource applicationGateway 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    trustedClientCertificates: []
    backendAddressPools: [
      {
        name: '${virtualNetwork.name}-beap'
        properties: {
          backendAddresses: []
        }
      }
    ]
    privateLinkConfigurations: []
    sslCertificates: []
    sslPolicy: {}
    sslProfiles: []
    trustedRootCertificates: []
    authenticationCertificates: []
    customErrorConfigurations: []
    frontendIPConfigurations: [
      {
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
        }
        name: '${virtualNetwork.name}-feip'
      }
    ]
    gatewayIPConfigurations: [
      {
        properties: {
          subnet: {}
        }
        name: 'my-gateway-ip-configuration'
      }
    ]
    sku: {
      capacity: 2
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    frontendPorts: [
      {
        name: '${virtualNetwork.name}-feport'
        properties: {
          port: 80
        }
      }
    ]
    redirectConfigurations: []
    rewriteRuleSets: []
    urlPathMaps: []
    requestRoutingRules: [
      {
        properties: {
          backendAddressPool: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendAddressPools',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-beap'
            )
          }
          backendHttpSettings: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/backendHttpSettingsCollection',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-be-htst'
            )
          }
          httpListener: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/httpListeners',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-httplstn'
            )
          }
          ruleType: 'Basic'
          priority: 10
        }
        name: '-rqrt'
      }
    ]
    backendHttpSettingsCollection: [
      {
        properties: {
          protocol: 'Http'
          requestTimeout: 1
          trustedRootCertificates: []
          path: ''
          port: 80
          authenticationCertificates: []
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
        }
        name: '${virtualNetwork.name}-be-htst'
      }
    ]
    enableHttp2: false
    httpListeners: [
      {
        name: '${virtualNetwork.name}-httplstn'
        properties: {
          frontendPort: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendPorts',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-feport'
            )
          }
          protocol: 'Http'
          requireServerNameIndication: false
          customErrorConfigurations: []
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-feip'
            )
          }
        }
      }
    ]
    probes: []
  }
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
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
