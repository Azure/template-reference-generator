param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource gallery 'Microsoft.Compute/galleries@2022-03-03' = {
  name: resourceName
  location: location
  properties: {
    description: ''
  }
}

resource application 'Microsoft.Compute/galleries/applications@2022-03-03' = {
  name: resourceName
  location: location
  parent: gallery
  properties: {
    supportedOSType: 'Linux'
  }
}
