param resourceName string = 'acctest0001'
param location string = 'westeurope'

var dataCollectionLogTableName = 'DataCollectionLog_CL'
var dataCollectionLogColumns = {} // TODO: Complex type needs manual conversion

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
  parent: workspace
  name: dataCollectionLogTableName
  properties: {
    schema: {
      name: dataCollectionLogTableName
      columns: dataCollectionLogColumns
    }
  }
}
