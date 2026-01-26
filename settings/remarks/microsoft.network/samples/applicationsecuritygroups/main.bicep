param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationSecurityGroup 'Microsoft.Network/applicationSecurityGroups@2022-09-01' = {
  name: resourceName
  location: location
}
