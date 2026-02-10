param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
          linkProperties: {
            linkProviderName: ''
            linkSpeedInMbps: 0
          }
          fqdn: ''
          ipAddress: '10.0.1.1'
        }
      }
      {
        name: 'link2'
        properties: {
          fqdn: ''
          ipAddress: '10.0.1.2'
          linkProperties: {
            linkProviderName: ''
            linkSpeedInMbps: 0
          }
        }
      }
    ]
  }
}
