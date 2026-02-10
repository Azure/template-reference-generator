param resourceName string = 'acctest0001'
param location string = 'westus2'

resource service 'Microsoft.HealthcareApis/services@2022-12-01' = {
  name: resourceName
  location: location
  kind: 'fhir'
  properties: {
    authenticationConfiguration: {}
    corsConfiguration: {}
    cosmosDbConfiguration: {
      offerThroughput: 1000
    }
    publicNetworkAccess: 'Enabled'
    accessPolicies: [
      {
        objectId: deployer().objectId
      }
    ]
  }
}
