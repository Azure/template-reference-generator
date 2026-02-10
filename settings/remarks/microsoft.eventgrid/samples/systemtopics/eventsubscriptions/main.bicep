param resourceName string = 'acctest0001'
param location string = 'westus'

var queueServiceId = '${storageAccount.id}/queueServices/default'
var storageAccountName = 'resourceNamesa01'
var queueName = 'resourceNamequeue'
var eventSubscription1Name = 'resourceName-es1'
var eventSubscription2Name = 'resourceName-es2'
var systemTopicName = 'resourceName-st'

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
    allowCrossTenantReplication: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
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
    isLocalUserEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
    defaultToOAuthAuthentication: false
    dnsEndpointType: 'Standard'
    isHnsEnabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
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
    deadLetterDestination: null
    destination: {
      properties: {
        queueName: queueName
        resourceId: storageAccount.id
      }
      endpointType: 'StorageQueue'
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
  }
}
