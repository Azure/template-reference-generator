param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vpnGateway 'Microsoft.Network/vpnGateways@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    isRoutingPreferenceInternet: false
    virtualHub: {
      id: virtualHub.id
    }
    vpnGatewayScaleUnit: 1
    enableBgpRouteTranslationForNat: false
  }
}

resource vpnSite 'Microsoft.Network/vpnSites@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
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
    addressSpace: {
      addressPrefixes: [
        '10.0.1.0/24'
      ]
    }
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
          vpnGatewayCustomBgpAddresses: []
          vpnSiteLink: {
            id: resourceId('Microsoft.Network/vpnSites/vpnSiteLinks', vpnSite.name, 'link1')
          }
          connectionBandwidth: 10
          enableRateLimiting: false
          routingWeight: 0
          useLocalAzureIpAddress: false
          usePolicyBasedTrafficSelectors: false
          vpnConnectionProtocolType: 'IKEv2'
          vpnLinkConnectionMode: 'Default'
          enableBgp: false
        }
      }
      {
        name: 'link2'
        properties: {
          useLocalAzureIpAddress: false
          usePolicyBasedTrafficSelectors: false
          vpnGatewayCustomBgpAddresses: []
          vpnLinkConnectionMode: 'Default'
          vpnConnectionProtocolType: 'IKEv2'
          vpnSiteLink: {
            id: resourceId('Microsoft.Network/vpnSites/vpnSiteLinks', vpnSite.name, 'link2')
          }
          connectionBandwidth: 10
          enableBgp: false
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
