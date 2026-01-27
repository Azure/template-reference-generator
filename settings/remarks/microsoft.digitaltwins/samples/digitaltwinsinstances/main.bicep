param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource digitalTwinsInstance 'Microsoft.DigitalTwins/digitalTwinsInstances@2020-12-01' = {
  name: resourceName
  location: location
}
