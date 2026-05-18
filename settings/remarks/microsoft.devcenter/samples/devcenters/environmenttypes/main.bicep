param resourceName string
param location string

resource devCenter 'Microsoft.DevCenter/devCenters@2025-02-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource environmentType 'Microsoft.DevCenter/devCenters/environmentTypes@2025-02-01' = {
  name: resourceName
  parent: devCenter
}
