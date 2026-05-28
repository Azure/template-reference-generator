param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource emailService 'Microsoft.Communication/emailServices@2023-03-31' = {
  name: resourceName
  location: 'global'
  properties: {
    dataLocation: 'United States'
  }
}
