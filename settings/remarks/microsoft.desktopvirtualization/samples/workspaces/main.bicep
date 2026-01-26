param resourceName string = 'acctest0001'
param location string = 'westus'

resource workspace 'Microsoft.DesktopVirtualization/workspaces@2024-04-03' = {
  name: resourceName
  location: location
  properties: {
    description: ''
    friendlyName: ''
    publicNetworkAccess: 'Enabled'
  }
}
