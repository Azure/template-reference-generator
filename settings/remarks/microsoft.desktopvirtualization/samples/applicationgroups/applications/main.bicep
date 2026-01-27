param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2023-09-05' = {
  name: resourceName
  location: location
  properties: {
    applicationGroupType: 'RemoteApp'
    hostPoolArmPath: hostPool.id
  }
}

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2023-09-05' = {
  name: resourceName
  location: location
  properties: {
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    maxSessionLimit: 999999
    preferredAppGroupType: 'Desktop'
    publicNetworkAccess: 'Enabled'
    startVMOnConnect: false
    validationEnvironment: false
  }
}

resource application 'Microsoft.DesktopVirtualization/applicationGroups/applications@2023-09-05' = {
  parent: applicationGroup
  name: resourceName
  location: location
  properties: {
    commandLineSetting: 'DoNotAllow'
    filePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
    showInPortal: false
  }
}
