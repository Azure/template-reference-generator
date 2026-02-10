param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: 'mi-security-group1-230630034008554952'
  location: location
  properties: {
    securityRules: []
  }
}

resource securityRule 'Microsoft.Network/networkSecurityGroups/securityRules@2022-09-01' = {
  name: 'allow_management_inbound'
  parent: networkSecurityGroup
  properties: {
    sourcePortRange: '*'
    access: 'Allow'
    destinationAddressPrefix: '*'
    destinationPortRange: ''
    direction: 'Inbound'
    protocol: 'Tcp'
    destinationPortRanges: [
      '9000'
      '1438'
      '1440'
      '9003'
      '1452'
    ]
    priority: 106
    sourceAddressPrefix: '*'
  }
}
