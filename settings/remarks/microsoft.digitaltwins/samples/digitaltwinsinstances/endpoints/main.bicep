param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource digitalTwinsInstance 'Microsoft.DigitalTwins/digitalTwinsInstances@2020-12-01' = {
  name: resourceName
  location: location
}

resource namespace 'Microsoft.ServiceBus/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    capacity: 0
    name: 'Standard'
    tier: 'Standard'
  }
}

resource endpoint 'Microsoft.DigitalTwins/digitalTwinsInstances/endpoints@2020-12-01' = {
  parent: digitalTwinsInstance
  name: resourceName
  properties: {
    authenticationType: 'KeyBased'
    deadLetterSecret: ''
    endpointType: 'ServiceBus'
    primaryConnectionString: 'authorizationRule.listKeys().primaryConnectionString'
    secondaryConnectionString: 'authorizationRule.listKeys().secondaryConnectionString'
  }
}

resource topic 'Microsoft.ServiceBus/namespaces/topics@2021-06-01-preview' = {
  parent: namespace
  name: resourceName
  properties: {
    enableBatchedOperations: false
    enableExpress: false
    enablePartitioning: false
    maxSizeInMegabytes: 5120
    requiresDuplicateDetection: false
    status: 'Active'
    supportOrdering: false
  }
}

resource authorizationRule 'Microsoft.ServiceBus/namespaces/topics/authorizationRules@2021-06-01-preview' = {
  parent: topic
  name: resourceName
  properties: {
    rights: [
      'Send'
    ]
  }
}
