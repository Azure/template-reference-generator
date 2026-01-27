param resourceName string = 'acctest0001'
param location string = 'westus'

var storageAccountName = '${resourceName}sa01'
var queueName = '${resourceName}queue'
var eventSubscription1Name = '${resourceName}-es1'
var eventSubscription2Name = '${resourceName}-es2'
var systemTopicName = '${resourceName}-st'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
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
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
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

resource eventSubscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  parent: systemTopic
  name: eventSubscription1Name
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
          values: ['foo']
        }
      ]
    }
    labels: []
  }
  dependsOn: [
    queue
  ]
}

resource eventsubscription1 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2022-06-15' = {
  parent: systemTopic
  name: eventSubscription2Name
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
          operatorType: 'StringEndsWith'
          values: ['bar']
        }
      ]
    }
    labels: []
  }
  dependsOn: [
    queue
  ]
}

// The queue service is a singleton named 'default' under the storage account
resource queueService 'Microsoft.Storage/storageAccounts/queueServices@2023-05-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource queue 'Microsoft.Storage/storageAccounts/queueServices/queues@2023-05-01' = {
  parent: queueService
  name: queueName

  dependsOn: [
    storageAccount
  ]
}
