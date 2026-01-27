param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.HealthcareApis/workspaces@2022-12-01' = {
  name: resourceName
  location: location
}

resource fhirService 'Microsoft.HealthcareApis/workspaces/fhirServices@2022-12-01' = {
  parent: workspace
  name: resourceName
  location: location
  kind: 'fhir-R4'
  properties: {
    acrConfiguration: {}
    authenticationConfiguration: {
      audience: 'https://acctestfhir.fhir.azurehealthcareapis.com'
      authority: 'https://login.microsoftonline.com/deployer().tenantId'
      smartProxyEnabled: false
    }
    corsConfiguration: {
      allowCredentials: false
      headers: []
      methods: []
      origins: []
    }
  }
}

resource fhirService2 'Microsoft.HealthcareApis/workspaces/fhirServices@2022-12-01' = {
  parent: workspace
  name: resourceName
  location: location
  kind: 'fhir-R4'
  properties: {
    acrConfiguration: {}
    authenticationConfiguration: {
      audience: fhirService.properties.authenticationConfiguration.audience
      authority: fhirService.properties.authenticationConfiguration.authority
      smartProxyEnabled: false
    }
    corsConfiguration: {
      allowCredentials: false
      headers: []
      methods: []
      origins: []
    }
  }
}
