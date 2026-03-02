param location string = 'westus'
param resourceName string = 'acctest0001'

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
