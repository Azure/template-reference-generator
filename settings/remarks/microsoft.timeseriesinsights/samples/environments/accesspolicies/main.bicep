param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource environment 'Microsoft.TimeSeriesInsights/environments@2020-05-15' = {
  name: resourceName
  location: location
  kind: 'Gen1'
  properties: {
    dataRetentionTime: 'P30D'
    storageLimitExceededBehavior: 'PurgeOldData'
  }
  sku: {
    capacity: 1
    name: 'S1'
  }
}

resource accessPolicy 'Microsoft.TimeSeriesInsights/environments/accessPolicies@2020-05-15' = {
  parent: environment
  name: resourceName
  properties: {
    description: ''
    principalObjectId: 'aGUID'
    roles: [
      'Reader'
    ]
  }
}
