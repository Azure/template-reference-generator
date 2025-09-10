param location string = 'westeurope'
param resource_name string = 'acctest0001'

resource configurationPolicyGroup 'Microsoft.Network/vpnServerConfigurations/configurationPolicyGroups@2022-07-01' = {
  parent: vpnServerConfiguration
  name: resource_name
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

resource vpnServerConfiguration 'Microsoft.Network/vpnServerConfigurations@2022-07-01' = {
  location: location
  name: resource_name
  properties: {
    radiusClientRootCertificates: []
    radiusServerAddress: ''
    radiusServerRootCertificates: []
    radiusServerSecret: ''
    radiusServers: [
      {
        radiusServerAddress: '10.105.1.1'
        radiusServerScore: 15
        radiusServerSecret: 'vindicators-the-return-of-worldender'
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

