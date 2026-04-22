param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The RADIUS server secret for VPN server configuration')
param radiusServerSecret string

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientIpsecPolicies: []
    vpnClientRevokedCertificates: []
    radiusClientRootCertificates: []
    radiusServerRootCertificates: []
    radiusServerSecret: '${radiusServerSecret}'
    vpnClientRootCertificates: []
    vpnProtocols: [
      'OpenVPN'
      'IkeV2'
    ]
    radiusServerAddress: ''
    radiusServers: [
      {
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
        radiusServerSecret: '${radiusServerSecret}'
      }
    ]
  }
}
