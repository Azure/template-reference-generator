param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationGateway 'Microsoft.Network/applicationGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    backendHttpSettingsCollection: [
      {
        name: '${virtualNetwork.name}-be-htst'
        properties: {
          authenticationCertificates: []
          cookieBasedAffinity: 'Disabled'
          protocol: 'Http'
          trustedRootCertificates: []
          path: ''
          pickHostNameFromBackendAddress: false
          port: 80
          requestTimeout: 1
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: '${virtualNetwork.name}-feip'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {}
        }
      }
    ]
    frontendPorts: [
      {
        name: '${virtualNetwork.name}-feport'
        properties: {
          port: 80
        }
      }
    ]
    trustedClientCertificates: []
    backendAddressPools: [
      {
        name: '${virtualNetwork.name}-beap'
        properties: {
          backendAddresses: []
        }
      }
    ]
    customErrorConfigurations: []
    httpListeners: [
      {
        name: '${virtualNetwork.name}-httplstn'
        properties: {
          customErrorConfigurations: []
          frontendIPConfiguration: {
            id: resourceId(
              'Microsoft.Network/applicationGateways/frontendIPConfigurations',
              resourceGroup().name,
              resourceName,
              '${virtualNetwork.name}-feip'
            )
          }
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
        }
      }
    ]
    privateLinkConfigurations: []
    probes: []
    redirectConfigurations: []
    sku: {
      capacity: 2
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    sslPolicy: {}
    authenticationCertificates: []
    gatewayIPConfigurations: [
      {
        name: 'my-gateway-ip-configuration'
        properties: {
          subnet: {}
        }
      }
    ]
    requestRoutingRules: [
      {
        name: '-rqrt'
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
      }
    ]
    rewriteRuleSets: []
    sslCertificates: []
    trustedRootCertificates: []
    urlPathMaps: []
    enableHttp2: false
    sslProfiles: []
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
    publicIPAllocationMethod: 'Static'
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
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
  name: 'subnet-230630033653837171'
  parent: virtualNetwork
  properties: {
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Disabled'
  }
}
