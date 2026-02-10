param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
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

resource consumerGroup 'Microsoft.EventHub/namespaces/eventhubs/consumerGroups@2021-11-01' = {
  name: resourceName
  parent: eventhub
  properties: {
    userMetadata: ''
  }
}

resource workspace 'Microsoft.HealthcareApis/workspaces@2022-12-01' = {
  name: resourceName
  location: location
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

resource fhirService 'Microsoft.HealthcareApis/workspaces/fhirServices@2022-12-01' = {
  name: resourceName
  location: location
  parent: workspace
  kind: 'fhir-R4'
  properties: {
    acrConfiguration: {}
    authenticationConfiguration: {
      audience: 'https://acctestfhir.fhir.azurehealthcareapis.com'
      authority: 'https://login.microsoftonline.com/${tenant().tenantId}'
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
