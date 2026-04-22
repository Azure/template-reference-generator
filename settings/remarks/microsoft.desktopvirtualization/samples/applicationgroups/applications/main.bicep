param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource applicationGroup 'Microsoft.DesktopVirtualization/applicationGroups@2023-09-05' = {
  name: resourceName
  location: location
  properties: {
    applicationGroupType: 'RemoteApp'
  }
}

resource application 'Microsoft.DesktopVirtualization/applicationGroups/applications@2023-09-05' = {
  name: resourceName
  location: location
  parent: applicationGroup
  properties: {
    commandLineSetting: 'DoNotAllow'
    filePath: 'C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe'
    showInPortal: false
  }
}

resource hostPool 'Microsoft.DesktopVirtualization/hostPools@2023-09-05' = {
  name: resourceName
  location: location
  properties: {
    startVMOnConnect: false
    validationEnvironment: false
    hostPoolType: 'Pooled'
    loadBalancerType: 'BreadthFirst'
    maxSessionLimit: 999999
    preferredAppGroupType: 'Desktop'
    publicNetworkAccess: 'Enabled'
  }
}
