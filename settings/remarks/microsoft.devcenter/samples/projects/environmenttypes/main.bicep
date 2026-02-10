param resourceName string
param location string

resource project 'Microsoft.DevCenter/projects@2025-02-01' = {
  name: '${resourceName}-proj'
  location: location
  properties: {
    devCenterId: devCenter.id
    maxDevBoxesPerUser: 0
    description: ''
  }
}

resource environmenttype1 'Microsoft.DevCenter/projects/environmentTypes@2025-02-01' = {
  name: 'azapi_resource.environmentType.name'
  parent: project
  properties: {
    deploymentTargetId: '/subscriptions/${subscription()}'
    status: 'Enabled'
  }
}

resource devCenter 'Microsoft.DevCenter/devCenters@2025-02-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource environmentType 'Microsoft.DevCenter/devCenters/environmentTypes@2025-02-01' = {
  name: '${resourceName}-envtype'
  parent: devCenter
}
