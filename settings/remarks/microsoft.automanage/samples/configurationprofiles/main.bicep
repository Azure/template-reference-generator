param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource configurationProfile 'Microsoft.Automanage/configurationProfiles@2022-05-04' = {
  name: resourceName
  location: location
  properties: {
    configuration: {}
  }
}
