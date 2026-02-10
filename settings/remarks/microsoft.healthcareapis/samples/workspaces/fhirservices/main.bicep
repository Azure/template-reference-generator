param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    corsConfiguration: {
      origins: []
      allowCredentials: false
      headers: []
      methods: []
    }
    acrConfiguration: {}
    authenticationConfiguration: {
      audience: 'https://acctestfhir.fhir.azurehealthcareapis.com'
      authority: 'https://login.microsoftonline.com/${tenant().tenantId}'
      smartProxyEnabled: false
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
      authority: fhirService.properties.authenticationConfiguration.authority
      smartProxyEnabled: false
      audience: fhirService.properties.authenticationConfiguration.audience
    }
    corsConfiguration: {
      allowCredentials: false
      headers: []
      methods: []
      origins: []
    }
  }
}
