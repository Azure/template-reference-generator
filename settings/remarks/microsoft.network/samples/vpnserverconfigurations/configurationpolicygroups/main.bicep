param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The RADIUS server secret for VPN authentication')
param radiusServerSecret string

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    radiusClientRootCertificates: []
    radiusServerRootCertificates: []
    vpnAuthenticationTypes: [
      'Radius'
    ]
    vpnClientIpsecPolicies: []
    vpnClientRevokedCertificates: []
    vpnClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerSecret: ''
    radiusServers: [
      {
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
        radiusServerSecret: '${radiusServerSecret}'
      }
    ]
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
    policyMembers: [
      {
        attributeType: 'RadiusAzureGroupId'
        attributeValue: '6ad1bd08'
        name: 'policy1'
      }
    ]
    priority: 0
    isDefault: false
  }
}
