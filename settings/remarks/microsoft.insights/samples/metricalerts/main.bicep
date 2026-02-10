param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource metricAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: resourceName
  location: 'global'
  properties: {
    scopes: []
    criteria: {
      allOf: [
        {
          dimensions: []
          metricName: 'UsedCapacity'
          metricNamespace: 'Microsoft.Storage/storageAccounts'
          name: 'Metric1'
          operator: 'GreaterThan'
          skipMetricValidation: false
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
          threshold: any('55.5')
        }
      ]
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
    }
    evaluationFrequency: 'PT1M'
    severity: 3
    targetResourceRegion: ''
    targetResourceType: ''
    windowSize: 'PT1H'
    actions: []
    autoMitigate: true
    description: ''
    enabled: true
  }
  tags: {
    Example: 'Example123'
    terraform: 'Coolllll'
    test: '123'
    CUSTOMER: 'CUSTOMERx'
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
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
    isSftpEnabled: false
  }
}
