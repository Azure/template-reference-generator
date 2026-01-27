param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    securityRules: []
  }
}
