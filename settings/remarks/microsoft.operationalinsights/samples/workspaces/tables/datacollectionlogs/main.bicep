param location string = 'westeurope'
param resourceName string = 'acctest0001'

var dataCollectionLogColumns = [
  {
    name: 'RawData'
    type: 'string'
  }
  {
    type: 'string'
    name: 'FilePath'
  }
  {
    type: 'datetime'
    name: 'TimeGenerated'
  }
]
var dataCollectionLogTableName = 'DataCollectionLog_CL'

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource table 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  name: dataCollectionLogTableName
  parent: workspace
  properties: {
    schema: {
      columns: dataCollectionLogColumns
      name: dataCollectionLogTableName
    }
  }
}
