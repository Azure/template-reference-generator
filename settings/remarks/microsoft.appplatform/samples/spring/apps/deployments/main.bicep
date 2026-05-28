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

resource app 'Microsoft.AppPlatform/Spring/apps@2023-05-01-preview' = {
  name: resourceName
  location: location
  parent: spring
  properties: {
    customPersistentDisks: []
    enableEndToEndTLS: false
    public: false
  }
}

resource deployment 'Microsoft.AppPlatform/Spring/apps/deployments@2023-05-01-preview' = {
  name: resourceName
  parent: app
  sku: {
    capacity: 1
    name: 'E0'
    tier: 'Enterprise'
  }
  properties: {
    deploymentSettings: {
      environmentVariables: {}
    }
    source: {
      customContainer: {
        args: []
        command: []
        containerImage: 'springio/gs-spring-boot-docker'
        languageFramework: ''
        server: 'docker.io'
      }
      type: 'Container'
    }
  }
}
