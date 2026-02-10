param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource workspace 'Microsoft.HealthcareApis/workspaces@2022-12-01' = {
  name: resourceName
  location: location
}

resource fhirService 'Microsoft.HealthcareApis/workspaces/fhirServices@2022-12-01' = {
  name: resourceName
  location: location
  parent: workspace
  kind: 'fhir-R4'
  properties: {
    acrConfiguration: {}
    authenticationConfiguration: {
      authority: 'https://login.microsoftonline.com/${tenant().tenantId}'
      smartProxyEnabled: false
      audience: 'https://acctestfhir.fhir.azurehealthcareapis.com'
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
  name: resourceName
  location: location
  parent: workspace
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
