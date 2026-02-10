param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    eventsOutOfOrderMaxDelayInSeconds: 50
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
    cluster: {}
    compatibilityLevel: '1.0'
    contentStoragePolicy: 'SystemAccount'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    outputErrorPolicy: 'Drop'
    sku: {
      name: 'Standard'
    }
    dataLocale: 'en-GB'
  }
}

resource output 'Microsoft.StreamAnalytics/streamingJobs/outputs@2021-10-01-preview' = {
  name: resourceName
  parent: streamingJob
  properties: {
    serialization: null
    datasource: {
      properties: {
        batchSize: 100
        partitionKey: 'foo'
        rowKey: 'bar'
        table: 'foobar'
        accountKey: storageAccount.listKeys().keys[0].value
        accountName: storageAccount.name
      }
      type: 'Microsoft.Storage/Table'
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
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
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
  }
}
