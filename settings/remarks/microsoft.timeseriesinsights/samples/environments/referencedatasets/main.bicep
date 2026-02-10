param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource environment 'Microsoft.TimeSeriesInsights/environments@2020-05-15' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'S1'
  }
  kind: 'Gen1'
  properties: {
    storageLimitExceededBehavior: 'PurgeOldData'
    dataRetentionTime: 'P30D'
  }
}

resource referenceDataSet 'Microsoft.TimeSeriesInsights/environments/referenceDataSets@2020-05-15' = {
  name: resourceName
  location: location
  parent: environment
  properties: {
    dataStringComparisonBehavior: 'Ordinal'
    keyProperties: [
      {
        type: 'String'
        name: 'keyProperty1'
      }
    ]
  }
}
