param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource ddosProtectionPlan 'Microsoft.Network/ddosProtectionPlans@2022-07-01' = {
  name: resourceName
  location: location
}
