param resourceName string = 'acctest0001'
param location string = 'westus'

var systemTopicName = 'resourceName-st'
var storageAccountName = 'resourceNamesa01'
var queueName = 'resourceNamequeue'
var eventSubscription1Name = 'resourceName-es1'
var eventSubscription2Name = 'resourceName-es2'
var queueServiceId = '${storageAccount.id}/queueServices/default'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isLocalUserEnabled: true
    isSftpEnabled: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    publicNetworkAccess: 'Enabled'
    isHnsEnabled: false
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    dnsEndpointType: 'Standard'
  }
}

resource systemTopic 'Microsoft.EventGrid/systemTopics@2022-06-15' = {
  name: systemTopicName
  location: 'global'
  properties: {
    source: resourceGroup().id
    topicType: 'Microsoft.Resources.ResourceGroups'
  }
}

resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  name: queueName
  dependsOn: [
    storageAccount
  ]
}

resource eventSubscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  name: eventSubscription1Name
  parent: systemTopic
  dependsOn: [
    queue
  ]
  properties: {
    deadLetterDestination: null
    destination: {
      endpointType: 'StorageQueue'
      properties: {
        queueName: queueName
        resourceId: storageAccount.id
      }
    }
    eventDeliverySchema: 'EventGridSchema'
    filter: {
      advancedFilters: [
        {
          key: 'subject'
          operatorType: 'StringBeginsWith'
          values: [
            'foo'
          ]
        }
      ]
    }
    labels: []
  }
}

resource eventsubscription1 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  name: eventSubscription2Name
  parent: systemTopic
  dependsOn: [
    queue
  ]
  properties: {
    filter: {
      advancedFilters: [
        {
          values: [
            'bar'
          ]
          key: 'subject'
          operatorType: 'StringEndsWith'
        }
      ]
    }
    labels: []
    deadLetterDestination: null
    destination: {
      endpointType: 'StorageQueue'
      properties: {
        queueName: queueName
        resourceId: storageAccount.id
      }
    }
    eventDeliverySchema: 'EventGridSchema'
  }
}
