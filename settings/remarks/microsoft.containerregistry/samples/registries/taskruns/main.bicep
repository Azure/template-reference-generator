param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    encryption: {
      status: 'disabled'
    }
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
    }
    publicNetworkAccess: 'Enabled'
    adminUserEnabled: false
    networkRuleBypassOptions: 'AzureServices'
    zoneRedundancy: 'Disabled'
  }
}

resource taskRun 'Microsoft.ContainerRegistry/registries/taskRuns@2019-06-01-preview' = {
  name: resourceName
  location: location
  parent: registry
  properties: {
    runRequest: {
      dockerFilePath: 'Dockerfile'
      imageNames: [
        'helloworld:{{.Run.ID}}'
        'helloworld:latest'
      ]
      platform: {
        os: 'Linux'
      }
      sourceLocation: 'https://github.com/Azure-Samples/aci-helloworld.git#master'
      type: 'DockerBuildRequest'
    }
  }
}
