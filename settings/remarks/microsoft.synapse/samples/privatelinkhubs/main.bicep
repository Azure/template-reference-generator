param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource privateLinkHub 'Microsoft.Synapse/privateLinkHubs@2021-06-01' = {
  name: resourceName
  location: location
}
