param location string = 'westeurope'
@secure()
@description('The RADIUS server secret for VPN server configuration')
param radiusServerSecret string
param resourceName string = 'acctest0001'

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientIpsecPolicies: []
    vpnClientRootCertificates: []
    radiusClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerSecret: '${radiusServerSecret}'
    radiusServers: [
      {
        radiusServerSecret: '${radiusServerSecret}'
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
      }
    ]
    vpnClientRevokedCertificates: []
    vpnProtocols: [
      'OpenVPN'
      'IkeV2'
    ]
    radiusServerRootCertificates: []
  }
}
