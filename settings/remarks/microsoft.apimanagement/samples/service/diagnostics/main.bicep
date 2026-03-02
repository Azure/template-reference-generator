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
    disableGateway: false
    publicNetworkAccess: 'Enabled'
    publisherEmail: 'pub1@email.com'
    publisherName: 'pub1'
    virtualNetworkType: 'None'
    certificates: []
    customProperties: {
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Ssl30': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Backend.Protocols.Tls11': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10': 'false'
      'Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11': 'false'
    }
  }
}

resource diagnostic 'Microsoft.ApiManagement/service/diagnostics@2021-08-01' = {
  name: 'applicationinsights'
  parent: service
  properties: {
    operationNameFormat: 'Name'
  }
}

resource logger 'Microsoft.ApiManagement/service/loggers@2021-08-01' = {
  name: resourceName
  parent: service
  properties: {
    isBuffered: true
    loggerType: 'applicationInsights'
    credentials: {
      instrumentationKey: component.properties.InstrumentationKey
    }
    description: ''
  }
}

resource component 'Microsoft.Insights/components@2020-02-02' = {
  name: resourceName
  location: location
  kind: 'web'
  properties: {
    publicNetworkAccessForQuery: 'Enabled'
    Application_Type: 'web'
    DisableIpMasking: false
    RetentionInDays: 90
    SamplingPercentage: 100
    publicNetworkAccessForIngestion: 'Enabled'
    DisableLocalAuth: false
    ForceCustomerStorageForProfiler: false
  }
}
