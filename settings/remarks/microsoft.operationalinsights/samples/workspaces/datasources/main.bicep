param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
  }
}

resource dataSource 'Microsoft.OperationalInsights/workspaces/dataSources@2020-08-01' = {
  name: resourceName
  parent: workspace
  kind: 'WindowsPerformanceCounter'
  properties: {
    counterName: 'CPU'
    instanceName: '*'
    intervalSeconds: 10
    objectName: 'CPU'
  }
}
