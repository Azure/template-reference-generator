param resourceName string = 'acctest0001'
param location string = 'westeurope'

var sentinelTiAlertsTableName = 'SentinelTIAlerts_CL'
var sentinelTiAlertsColumns = [
  {
    type: 'int'
    name: 'ConfidenceScore'
  }
  {
    name: 'ExternalIndicatorId'
    type: 'string'
  }
  {
    name: 'IndicatorType'
    type: 'string'
  }
  {
    name: 'Indicator'
    type: 'string'
  }
  {
    type: 'datetime'
    name: 'TimeGenerated'
  }
  {
    name: 'MatchType'
    type: 'string'
  }
  {
    name: 'OriginTimestamp'
    type: 'datetime'
  }
  {
    name: 'Details'
    type: 'dynamic'
  }
]

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
  }
}

resource table 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  name: sentinelTiAlertsTableName
  parent: workspace
  properties: {
    retentionInDays: 30
    schema: {
      columns: '${sentinelTiAlertsColumns}'
      name: '${sentinelTiAlertsTableName}'
    }
    totalRetentionInDays: 30
  }
}
