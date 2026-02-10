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
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
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
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource streamingJob 'Microsoft.StreamAnalytics/streamingJobs@2020-03-01' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'Standard'
    }
    transformation: {
      name: 'main'
      properties: {
        streamingUnits: 3
        query: '''    SELECT *
    INTO [YourOutputAlias]
    FROM [YourInputAlias]
'''
      }
    }
    cluster: {}
    contentStoragePolicy: 'SystemAccount'
    dataLocale: 'en-GB'
    eventsOutOfOrderPolicy: 'Adjust'
    jobType: 'Cloud'
    compatibilityLevel: '1.0'
    eventsLateArrivalMaxDelayInSeconds: 60
    eventsOutOfOrderMaxDelayInSeconds: 50
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
