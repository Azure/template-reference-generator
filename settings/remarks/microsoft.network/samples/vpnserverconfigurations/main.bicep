param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The RADIUS server secret for VPN server configuration')
param radiusServerSecret string

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    radiusClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerRootCertificates: []
    radiusServerSecret: null
    radiusServers: [
      {
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
        radiusServerSecret: null
      }
    ]
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientIpsecPolicies: []
    vpnClientRevokedCertificates: []
    vpnClientRootCertificates: []
    vpnProtocols: [
      'OpenVPN'
      'IkeV2'
    ]
  }
}
