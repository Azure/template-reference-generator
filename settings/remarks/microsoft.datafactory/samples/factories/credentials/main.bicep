param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: resourceName
  location: 'azapi_resource.resourceGroup.location'
}

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    repoConfiguration: null
  }
}

resource credential 'Microsoft.DataFactory/factories/credentials@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    type: 'ManagedIdentity'
    annotations: [
      'test'
    ]
    description: 'this is a test'
    typeProperties: {
      resourceId: userAssignedIdentity.id
    }
  }
}
