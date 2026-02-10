param resourceName string = 'acctest0001'
param location string = 'westus'

resource job 'Microsoft.App/jobs@2025-01-01' = {
  name: '${resourceName}-cajob'
  location: location
  properties: {
    configuration: {
      manualTriggerConfig: {
        replicaCompletionCount: 1
        parallelism: 4
      }
      replicaRetryLimit: 10
      replicaTimeout: 10
      triggerType: 'Manual'
    }
    template: {
      volumes: []
      containers: [
        {
          image: 'jackofallops/azure-containerapps-python-acctest:v0.0.1'
          name: 'testcontainerappsjob0'
          probes: []
          resources: {
            cpu: any('0.5')
            memory: '1Gi'
          }
          volumeMounts: []
          env: []
        }
      ]
      initContainers: []
    }
  }
}

resource managedEnvironment 'Microsoft.App/managedEnvironments@2025-01-01' = {
  name: '${resourceName}-env'
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        sharedKey: workspace.listKeys().primarySharedKey
      }
    }
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' = {
  name: '${resourceName}-law'
  location: location
  properties: {
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
  }
}
