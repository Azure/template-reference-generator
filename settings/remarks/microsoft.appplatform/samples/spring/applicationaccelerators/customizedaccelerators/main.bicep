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

resource applicationAccelerator 'Microsoft.AppPlatform/Spring/applicationAccelerators@2023-05-01-preview' = {
  name: 'default'
  parent: spring
}

resource customizedAccelerator 'Microsoft.AppPlatform/Spring/applicationAccelerators/customizedAccelerators@2023-05-01-preview' = {
  name: resourceName
  parent: applicationAccelerator
  properties: {
    description: ''
    displayName: ''
    gitRepository: {
      gitTag: ''
      url: 'https://github.com/Azure-Samples/piggymetrics'
      authSetting: {
        authType: 'Public'
      }
      branch: 'master'
      commit: ''
    }
    iconUrl: ''
  }
}
