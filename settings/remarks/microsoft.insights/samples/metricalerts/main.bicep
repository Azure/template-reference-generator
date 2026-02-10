param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: resourceName
  location: 'global'
  properties: {
    targetResourceRegion: ''
    targetResourceType: ''
    criteria: {
      allOf: [
        {
          dimensions: []
          metricNamespace: 'Microsoft.Storage/storageAccounts'
          name: 'Metric1'
          operator: 'GreaterThan'
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
          metricName: 'UsedCapacity'
          skipMetricValidation: false
          threshold: any('55.5')
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    evaluationFrequency: 'PT1M'
    windowSize: 'PT1H'
    actions: []
    autoMitigate: true
    description: ''
    enabled: true
    scopes: []
    severity: 3
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
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
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
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}
