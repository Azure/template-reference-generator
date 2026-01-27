param resourceName string = 'acctest0001'
param location string = 'westus'

resource fleet 'Microsoft.ContainerService/fleets@2024-04-01' = {
  name: resourceName
  location: location
  properties: {}
}
