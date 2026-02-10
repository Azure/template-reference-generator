param resourceName string = 'acctest0001'
param location string = 'westeurope'

var auditLogTableName = 'AuditLog_CL'
var auditLogColumns = [
  {
    name: 'appId'
    type: 'string'
  }
  {
    type: 'string'
    name: 'correlationId'
  }
  {
    type: 'datetime'
    name: 'TimeGenerated'
  }
]

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
      disableLocalAuth: false
    }
  }
}

resource table 'Microsoft.OperationalInsights/workspaces/tables@2022-10-01' = {
  name: auditLogTableName
  parent: workspace
  properties: {
    schema: {
      columns: '${auditLogColumns}'
      name: '${auditLogTableName}'
    }
  }
}
