param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Consumption'
    capacity: 0
  }
  properties: {
    virtualNetworkType: 'None'
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  name: '${resourceName};rev=1'
  parent: service
  properties: {
    value: 'http://conferenceapi.azurewebsites.net/?format=json'
    apiType: 'http'
    apiVersion: ''
    format: 'swagger-link-json'
    path: 'test'
    type: 'http'
  }
}

resource diagnostic 'Microsoft.ApiManagement/service/apis/diagnostics@2021-08-01' = {
  name: 'applicationinsights'
  parent: api
  properties: {
    loggerId: logger.id
    operationNameFormat: 'Name'
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    Application_Type: 'web'
    DisableLocalAuth: false
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    ForceCustomerStorageForProfiler: false
    RetentionInDays: 90
    SamplingPercentage: 100
  }
}

resource logger 'Microsoft.ApiManagement/service/loggers@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    loggerType: 'applicationInsights'
    credentials: {
      instrumentationKey: component.properties.InstrumentationKey
    }
    description: ''
    isBuffered: true
  }
}
