param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource gallery 'Microsoft.Compute/galleries@2022-03-03' = {
  name: resourceName
  location: location
  properties: {
    description: ''
  }
}
