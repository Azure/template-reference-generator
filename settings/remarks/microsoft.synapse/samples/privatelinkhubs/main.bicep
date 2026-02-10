param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource privateLinkHub 'Microsoft.Synapse/privateLinkHubs@2021-06-01' = {
  name: resourceName
  location: location
}
