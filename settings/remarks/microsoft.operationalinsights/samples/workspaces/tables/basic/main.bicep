param resourceName string = 'acctest0001'
param location string = 'westeurope'

var sentinelTiAlertsTableName = 'SentinelTIAlerts_CL'
var sentinelTiAlertsColumns = {} // TODO: Complex type needs manual conversion

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
  name: sentinelTiAlertsTableName
  properties: {
    schema: {
      name: sentinelTiAlertsTableName
      columns: sentinelTiAlertsColumns
    }
    retentionInDays: 30
    totalRetentionInDays: 30
  }
}
