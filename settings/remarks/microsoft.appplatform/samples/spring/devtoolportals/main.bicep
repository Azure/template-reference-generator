param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'E0'
  }
  properties: {
    zoneRedundant: false
  }
}

resource devToolPortal 'Microsoft.AppPlatform/Spring/DevToolPortals@2023-05-01-preview' = {
  name: 'default'
  parent: spring
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
