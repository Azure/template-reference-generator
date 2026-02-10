param resourceName string = 'acctest0001'
param location string = 'westus'

resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2024-04-03' = {
  name: '${resourceName}-ag'
  location: location
  properties: {
    applicationGroupType: 'Desktop'
    description: ''
    friendlyName: ''
  }
}

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2024-04-03' = {
  name: '${resourceName}-hp'
  location: location
  properties: {
    friendlyName: ''
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    maxSessionLimit: 999999
    personalDesktopAssignmentType: ''
    preferredAppGroupType: 'Desktop'
    startVMOnConnect: false
    validationEnvironment: false
    customRdpProperty: ''
    description: ''
    publicNetworkAccess: 'Enabled'
    vmTemplate: ''
  }
}
