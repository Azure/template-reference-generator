param location string = 'westeurope'
@secure()
@description('The RADIUS server secret for VPN authentication')
param radiusServerSecret string
param resourceName string = 'acctest0001'

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    radiusServerRootCertificates: []
    radiusServers: [
      {
        radiusServerScore: 15
        radiusServerSecret: '${radiusServerSecret}'
        radiusServerAddress: '10.105.1.1'
      }
    ]
    vpnClientRevokedCertificates: []
    vpnClientRootCertificates: []
    radiusClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerSecret: ''
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientIpsecPolicies: []
    vpnProtocols: [
      'OpenVPN'
      'IkeV2'
    ]
  }
}

resource configurationPolicyGroup 'Microsoft.Network/vpnServerConfigurations/configurationPolicyGroups@2022-07-01' = {
  name: resourceName
  parent: vpnServerConfiguration
  properties: {
    isDefault: false
    policyMembers: [
      {
        attributeValue: '6ad1bd08'
        name: 'policy1'
        attributeType: 'RadiusAzureGroupId'
      }
    ]
    priority: 0
  }
}
