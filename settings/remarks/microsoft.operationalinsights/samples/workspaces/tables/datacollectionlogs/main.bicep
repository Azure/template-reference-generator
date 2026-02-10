param resourceName string = 'acctest0001'
param location string = 'westeurope'

var dataCollectionLogTableName = 'DataCollectionLog_CL'
var dataCollectionLogColumns = [
  {
    type: 'string'
    name: 'RawData'
  }
  {
    name: 'FilePath'
    type: 'string'
  }
  {
    name: 'TimeGenerated'
    type: 'datetime'
  }
]

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
      columns: '${dataCollectionLogColumns}'
      name: '${dataCollectionLogTableName}'
    }
  }
}
