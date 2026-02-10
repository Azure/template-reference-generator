param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource environment 'Microsoft.TimeSeriesInsights/environments@2020-05-15' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
    capacity: 1
  }
  kind: 'Gen1'
  properties: {
    dataRetentionTime: 'P30D'
    storageLimitExceededBehavior: 'PurgeOldData'
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
        name: 'keyProperty1'
        type: 'String'
      }
    ]
  }
}
