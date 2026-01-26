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

resource applicationAccelerator 'Microsoft.AppPlatform/Spring/applicationAccelerators@2023-05-01-preview' = {
  parent: spring
  name: 'default'
}

resource customizedAccelerator 'Microsoft.AppPlatform/Spring/applicationAccelerators/customizedAccelerators@2023-05-01-preview' = {
  parent: applicationAccelerator
  name: resourceName
  properties: {
    description: ''
    displayName: ''
    gitRepository: {
      authSetting: {
        authType: 'Public'
      }
      branch: 'master'
      commit: ''
      gitTag: ''
      url: 'https://github.com/Azure-Samples/piggymetrics'
    }
    iconUrl: ''
  }
}
