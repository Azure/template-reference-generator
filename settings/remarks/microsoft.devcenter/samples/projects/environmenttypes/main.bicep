param resourceName string
param location string

resource devCenter 'Microsoft.DevCenter/devCenters@2025-02-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource project 'Microsoft.DevCenter/projects@2025-02-01' = {
  name: '${resourceName}-proj'
  location: location
  properties: {
    description: ''
    devCenterId: devCenter.id
    maxDevBoxesPerUser: 0
  }
}

resource environmentType 'Microsoft.DevCenter/devCenters/environmentTypes@2025-02-01' = {
  parent: devCenter
  name: '${resourceName}-envtype'
}

resource environmenttype1 'Microsoft.DevCenter/projects/environmentTypes@2025-02-01' = {
  parent: project
  name: 'environmentType.name'
  properties: {
    deploymentTargetId: '/subscriptions/subscription().subscriptionId'
    status: 'Enabled'
  }
}
