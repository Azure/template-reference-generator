param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource registry 'Microsoft.ContainerRegistry/registries@2021-08-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    encryption: {
      status: 'disabled'
    }
    networkRuleBypassOptions: 'AzureServices'
    publicNetworkAccess: 'Enabled'
    adminUserEnabled: false
    anonymousPullEnabled: false
    dataEndpointEnabled: false
    policies: {
      exportPolicy: {
        status: 'enabled'
      }
      quarantinePolicy: {
        status: 'disabled'
      }
      retentionPolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        status: 'disabled'
      }
    }
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
