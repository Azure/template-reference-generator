param resourceName string = 'acctest0001'
param location string = 'westeurope'

var auditLogColumns = [
  {
    name: 'appId'
    type: 'string'
  }
  {
    name: 'correlationId'
    type: 'string'
  }
  {
    name: 'TimeGenerated'
    type: 'datetime'
  }
]
var auditLogTableName = 'AuditLog_CL'

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
  name: auditLogTableName
  parent: workspace
  properties: {
    schema: {
      name: '${auditLogTableName}'
      columns: '${auditLogColumns}'
    }
  }
}
