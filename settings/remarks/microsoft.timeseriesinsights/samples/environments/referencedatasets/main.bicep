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

resource referenceDataSet 'Microsoft.TimeSeriesInsights/environments/referenceDataSets@2020-05-15' = {
  parent: environment
  name: resourceName
  location: location
  properties: {
    dataStringComparisonBehavior: 'Ordinal'
    keyProperties: [
      {
        name: 'keyProperty1'
        type: 'String'
      }
    ]
  }
}
