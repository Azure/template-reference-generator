param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource service 'Microsoft.ApiManagement/service@2021-08-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 0
    name: 'Consumption'
  }
  properties: {
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
    }
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
  }
}

resource api 'Microsoft.ApiManagement/service/apis@2021-08-01' = {
  name: '${resourceName};rev=1'
  parent: service
  properties: {
    apiType: 'http'
    apiVersion: ''
    format: 'swagger-link-json'
    path: 'test'
    type: 'http'
    value: 'http://conferenceapi.azurewebsites.net/?format=json'
  }
}

resource logger 'Microsoft.ApiManagement/service/loggers@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    credentials: {
      instrumentationKey: component.properties.InstrumentationKey
    }
    description: ''
    isBuffered: true
    loggerType: 'applicationInsights'
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
    Application_Type: 'web'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
    SamplingPercentage: 100
    publicNetworkAccessForQuery: 'Enabled'
    DisableIpMasking: false
    RetentionInDays: 90
    publicNetworkAccessForIngestion: 'Enabled'
  }
}
