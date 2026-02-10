param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    cluster: {}
    contentStoragePolicy: 'SystemAccount'
    eventsOutOfOrderMaxDelayInSeconds: 50
    jobType: 'Cloud'
    sku: {
      name: 'Standard'
    }
    transformation: {
      name: 'main'
      properties: {
        query: '''    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
'''
        streamingUnits: 3
      }
    }
    compatibilityLevel: '1.0'
    dataLocale: 'en-GB'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderPolicy: 'Adjust'
    outputErrorPolicy: 'Drop'
  }
}

resource output 'Microsoft.StreamAnalytics/streamingJobs/outputs@2021-10-01-preview' = {
  name: resourceName
  parent: streamingJob
  properties: {
    datasource: {
      properties: {
        accountKey: storageAccount.listKeys().keys[0].value
        accountName: storageAccount.name
        batchSize: 100
        partitionKey: 'foo'
        rowKey: 'bar'
        table: 'foobar'
      }
      type: 'Microsoft.Storage/Table'
    }
    serialization: null
  }
}
