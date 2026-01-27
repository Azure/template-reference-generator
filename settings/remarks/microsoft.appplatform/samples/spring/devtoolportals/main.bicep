param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    zoneRedundant: false
  }
  sku: {
    name: 'E0'
  }
}

resource devtoolportal 'Microsoft.AppPlatform/Spring/DevToolPortals@2023-05-01-preview' = {
  parent: spring
  name: 'default'
  properties: {
    features: {
      applicationAccelerator: {
        state: 'Disabled'
      }
      applicationLiveView: {
        state: 'Disabled'
      }
    }
    public: false
  }
}
