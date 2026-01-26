param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource configurationProfile 'Microsoft.Automanage/configurationProfiles@2022-05-04' = {
  name: resourceName
  location: location
  properties: {
    configuration: {}
  }
}
