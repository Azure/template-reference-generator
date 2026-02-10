param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: resourceName
  location: location
  properties: {
    configuration: {
      activeRevisionsMode: 'Single'
    }
    template: {
      containers: [
        {
          image: 'jackofallops/azure-containerapps-python-acctest:v0.0.1'
          name: 'acctest-cont-230630032906865620'
          probes: []
          resources: {
            cpu: any('0.25')
            ephemeralStorage: '1Gi'
            memory: '0.5Gi'
          }
          volumeMounts: []
          env: []
        }
      ]
      scale: {
        maxReplicas: 10
      }
      volumes: []
    }
  }
}

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
    workspaceCapping: {
      dailyQuotaGb: -1
    }
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
  }
}
