param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: resourceName
  location: 'global'
  properties: {
    actions: []
    autoMitigate: true
    criteria: {
      allOf: [
        {
          criterionType: 'StaticThresholdCriterion'
          dimensions: []
          metricName: 'UsedCapacity'
          metricNamespace: 'Microsoft.Storage/storageAccounts'
          name: 'Metric1'
          operator: 'GreaterThan'
          skipMetricValidation: false
          threshold: any('55.5')
          timeAggregation: 'Average'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    description: ''
    enabled: true
    evaluationFrequency: 'PT1M'
    scopes: [
      storageAccount.id
    ]
    severity: 3
    targetResourceRegion: ''
    targetResourceType: ''
    windowSize: 'PT1H'
  }
  tags: {
    CUSTOMER: 'CUSTOMERx'
    Example: 'Example123'
    terraform: 'Coolllll'
    test: '123'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
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
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}
