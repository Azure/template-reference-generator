param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource virtualWan 'Microsoft.Network/virtualWans@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    allowBranchToBranchTraffic: true
    disableVpnEncryption: false
    office365LocalBreakoutCategory: 'None'
    type: 'Standard'
  }
}

resource vpnGateway 'Microsoft.Network/vpnGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableBgpRouteTranslationForNat: false
    isRoutingPreferenceInternet: false
    virtualHub: {
      id: virtualHub.id
    }
    vpnGatewayScaleUnit: 1
  }
}

resource vpnSite 'Microsoft.Network/vpnSites@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.1.0/24'
      ]
    }
    virtualWan: {
      id: virtualWan.id
    }
    vpnSiteLinks: [
      {
        name: 'link1'
        properties: {
          fqdn: ''
          ipAddress: '10.0.1.1'
          linkProperties: {
            linkProviderName: ''
            linkSpeedInMbps: 0
          }
        }
      }
      {
        name: 'link2'
        properties: {
          fqdn: ''
          ipAddress: '10.0.1.2'
          linkProperties: {
            linkSpeedInMbps: 0
            linkProviderName: ''
          }
        }
      }
    ]
  }
}

resource vpnConnection 'Microsoft.Network/vpnGateways/vpnConnections@2022-07-01' = {
  name: resourceName
  parent: vpnGateway
  properties: {
    enableInternetSecurity: false
    remoteVpnSite: {
      id: vpnSite.id
    }
    vpnLinkConnections: [
      {
        name: 'link1'
        properties: {
          enableBgp: false
          enableRateLimiting: false
          useLocalAzureIpAddress: false
          vpnConnectionProtocolType: 'IKEv2'
          vpnLinkConnectionMode: 'Default'
          vpnSiteLink: {
            id: resourceId('Microsoft.Network/vpnSites/vpnSiteLinks', vpnSite.name, 'link1')
          }
          routingWeight: 0
          usePolicyBasedTrafficSelectors: false
          vpnGatewayCustomBgpAddresses: []
          connectionBandwidth: 10
        }
      }
      {
        name: 'link2'
        properties: {
          usePolicyBasedTrafficSelectors: false
          vpnConnectionProtocolType: 'IKEv2'
          connectionBandwidth: 10
          enableBgp: false
          useLocalAzureIpAddress: false
          vpnGatewayCustomBgpAddresses: []
          vpnLinkConnectionMode: 'Default'
          vpnSiteLink: {
            id: resourceId('Microsoft.Network/vpnSites/vpnSiteLinks', vpnSite.name, 'link2')
          }
          enableRateLimiting: false
          routingWeight: 0
        }
      }
    ]
  }
}

resource virtualHub 'Microsoft.Network/virtualHubs@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressPrefix: '10.0.0.0/24'
    hubRoutingPreference: 'ExpressRoute'
    virtualRouterAutoScaleConfiguration: {
      minCapacity: 2
    }
    virtualWan: {}
  }
}
