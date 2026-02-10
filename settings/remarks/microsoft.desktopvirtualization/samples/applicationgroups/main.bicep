param resourceName string = 'acctest0001'
param location string = 'westus'

resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2024-04-03' = {
  name: '${resourceName}-ag'
  location: location
  properties: {
    description: ''
    friendlyName: ''
    applicationGroupType: 'Desktop'
  }
}

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2024-04-03' = {
  name: '${resourceName}-hp'
  location: location
  properties: {
    vmTemplate: ''
    customRdpProperty: ''
    friendlyName: ''
    hostPoolType: 'Pooled'
    maxSessionLimit: 999999
    personalDesktopAssignmentType: ''
    preferredAppGroupType: 'Desktop'
    validationEnvironment: false
    description: ''
    loadBalancerType: 'BreadthFirst'
    publicNetworkAccess: 'Enabled'
    startVMOnConnect: false
  }
}
