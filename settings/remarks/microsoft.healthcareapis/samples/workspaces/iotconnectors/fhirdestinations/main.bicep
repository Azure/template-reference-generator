param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
    isAutoInflateEnabled: false
  }
}

resource workspace 'Microsoft.HealthcareApis/workspaces@2022-12-01' = {
  name: resourceName
  location: location
}

resource eventhub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  name: resourceName
  parent: namespace
  properties: {
    messageRetentionInDays: 1
    partitionCount: 2
    status: 'Active'
  }
}

resource fhirService 'Microsoft.HealthcareApis/workspaces/fhirServices@2022-12-01' = {
  name: resourceName
  location: location
  parent: workspace
  kind: 'fhir-R4'
  properties: {
    acrConfiguration: {}
    authenticationConfiguration: {
      smartProxyEnabled: false
      audience: 'https://acctestfhir.fhir.azurehealthcareapis.com'
      authority: 'https://login.microsoftonline.com/${tenant()}'
    }
    corsConfiguration: {
      allowCredentials: false
      headers: []
      methods: []
      origins: []
    }
  }
}

resource iotConnector 'Microsoft.HealthcareApis/workspaces/iotConnectors@2022-12-01' = {
  name: resourceName
  location: location
  parent: workspace
  properties: {
    deviceMapping: {
      content: {
        template: []
        templateType: 'CollectionContent'
      }
    }
    ingestionEndpointConfiguration: {
      eventHubName: eventhub.name
      fullyQualifiedEventHubNamespace: '${namespace.name}.servicebus.windows.net'
    }
  }
}

resource consumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumerGroups@2021-11-01' = {
  name: resourceName
  parent: eventhub
  properties: {
    userMetadata: ''
  }
}

resource fhirDestination 'Microsoft.HealthcareApis/workspaces/iotConnectors/fhirDestinations@2022-12-01' = {
  name: resourceName
  location: location
  parent: iotConnector
  properties: {
    fhirMapping: {
      content: {
        template: []
        templateType: 'CollectionFhirTemplate'
      }
    }
    fhirServiceResourceId: fhirService.id
    resourceIdentityResolutionType: 'Create'
  }
}
