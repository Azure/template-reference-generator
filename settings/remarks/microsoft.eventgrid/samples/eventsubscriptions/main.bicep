param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    defaultToOAuthAuthentication: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
  }
}

resource eventSubscription 'Microsoft.EventGrid/eventSubscriptions@2021-12-01' = {
  name: resourceName
  scope: storageAccount
  properties: {
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
        'Microsoft.Storage.BlobRenamed'
      ]
    }
    labels: []
    retryPolicy: {
      eventTimeToLiveInMinutes: 144
      maxDeliveryAttempts: 10
    }
    deadLetterDestination: null
    destination: {
      endpointType: 'EventHub'
      properties: {
        deliveryAttributeMappings: null
      }
    }
    eventDeliverySchema: 'EventGridSchema'
  }
}

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
    isAutoInflateEnabled: false
  }
}

resource eventhub 'Microsoft.EventHub/namespaces/eventhubs@2021-11-01' = {
  name: resourceName
  parent: namespace
  properties: {
    status: 'Active'
    messageRetentionInDays: 1
    partitionCount: 1
  }
}
