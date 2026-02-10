@secure()
@description('The RADIUS server secret for VPN authentication')
param radiusServerSecret string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    vpnProtocols: [
      'OpenVPN'
      'IkeV2'
    ]
    radiusServerSecret: ''
    radiusServers: [
      {
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
        radiusServerSecret: '${radiusServerSecret}'
      }
    ]
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientRevokedCertificates: []
    vpnClientRootCertificates: []
    radiusClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerRootCertificates: []
    vpnClientIpsecPolicies: []
  }
}

resource configurationPolicyGroup 'Microsoft.Network/vpnServerConfigurations/configurationPolicyGroups@2022-07-01' = {
  name: resourceName
  parent: vpnServerConfiguration
  properties: {
    isDefault: false
    policyMembers: [
      {
        attributeType: 'RadiusAzureGroupId'
        attributeValue: '6ad1bd08'
        name: 'policy1'
      }
    ]
    priority: 0
  }
}
