param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource builder 'Microsoft.AppPlatform/Spring/buildServices/builders@2023-05-01-preview' = {
  name: resourceName
  properties: {
    buildpackGroups: [
      {
        buildpacks: [
          {
            id: 'tanzu-buildpacks/java-azure'
          }
        ]
        name: 'mix'
      }
    ]
    stack: {
      id: 'io.buildpacks.stacks.bionic'
      version: 'base'
    }
  }
}

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

resource buildService 'Microsoft.AppPlatform/Spring/buildServices@2023-05-01-preview' = {
  name: 'default'
  parent: spring
  properties: {}
}
