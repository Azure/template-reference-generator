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
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
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
    isSftpEnabled: false
    supportsHttpsTrafficOnly: true
  }
}

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: resourceName
  location: 'global'
  properties: {
    severity: 3
    criteria: {
      allOf: [
        {
          dimensions: []
          metricName: 'UsedCapacity'
          name: 'Metric1'
          operator: 'GreaterThan'
          skipMetricValidation: false
          threshold: any('55.5')
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
          metricNamespace: 'Microsoft.Storage/storageAccounts'
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    description: ''
    enabled: true
    targetResourceRegion: ''
    targetResourceType: ''
    windowSize: 'PT1H'
    actions: []
    autoMitigate: true
    evaluationFrequency: 'PT1M'
    scopes: []
  }
  tags: {
    CUSTOMER: 'CUSTOMERx'
    Example: 'Example123'
    terraform: 'Coolllll'
    test: '123'
  }
}
