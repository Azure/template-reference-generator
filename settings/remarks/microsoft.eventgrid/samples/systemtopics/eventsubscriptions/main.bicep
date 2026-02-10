param resourceName string = 'acctest0001'
param location string = 'westus'

var eventSubscription2Name = 'resourceName-es2'
var systemTopicName = 'resourceName-st'
var storageAccountName = 'resourceNamesa01'
var queueName = 'resourceNamequeue'
var queueServiceId = '${storageAccount.id}/queueServices/default'
var eventSubscription1Name = 'resourceName-es1'

resource systemTopic 'Microsoft.EventGrid/systemTopics@2022-06-15' = {
  name: systemTopicName
  location: 'global'
  properties: {
    source: resourceGroup().id
    topicType: 'Microsoft.Resources.ResourceGroups'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isLocalUserEnabled: true
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: true
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    networkAcls: {
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
    }
    accessTier: 'Hot'
    dnsEndpointType: 'Standard'
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
    isSftpEnabled: false
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
          operatorType: 'StringBeginsWith'
          values: [
            'foo'
          ]
          key: 'subject'
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
          operatorType: 'StringEndsWith'
          values: [
            'bar'
          ]
        }
      ]
    }
    labels: []
    deadLetterDestination: null
  }
}
