param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    repoConfiguration: null
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
}

resource credential 'Microsoft.DataFactory/factories/credentials@2018-06-01' = {
  parent: factory
  name: resourceName
  properties: {
    annotations: [
      'test'
    ]
    description: 'this is a test'
    type: 'ManagedIdentity'
    typeProperties: {
      resourceId: userAssignedIdentity.id
    }
  }
}
