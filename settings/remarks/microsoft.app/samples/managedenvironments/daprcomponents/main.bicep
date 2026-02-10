param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource managedEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: resourceName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        sharedKey: workspace.listKeys().primarySharedKey
      }
    }
    vnetConfiguration: {}
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
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
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource daprComponent 'Microsoft.App/managedEnvironments/daprComponents@2022-03-01' = {
  name: resourceName
  parent: managedEnvironment
  properties: {
    componentType: 'state.azure.blobstorage'
    ignoreErrors: false
    initTimeout: '5s'
    scopes: null
    version: 'v1'
  }
}
