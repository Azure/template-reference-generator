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
    publicNetworkAccess: 'Enabled'
    startVMOnConnect: false
    loadBalancerType: 'BreadthFirst'
    personalDesktopAssignmentType: ''
    validationEnvironment: false
    vmTemplate: ''
    customRdpProperty: ''
    description: ''
    friendlyName: ''
    hostPoolType: 'Pooled'
    maxSessionLimit: 999999
    preferredAppGroupType: 'Desktop'
  }
}
