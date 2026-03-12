param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource communicationService 'Microsoft.Communication/communicationServices@2023-03-31' = {
  name: resourceName
  location: 'global'
  properties: {
    dataLocation: 'United States'
  }
}
