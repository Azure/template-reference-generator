param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource account 'Microsoft.Monitor/accounts@2023-04-03' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource prometheusRuleGroup 'Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    clusterName: ''
    description: ''
    enabled: false
    rules: [
      {
        enabled: false
        expression: '''histogram_quantile(0.99, sum(rate(jobs_duration_seconds_bucket{service="billing-processing"}[5m])) by (job_type))
'''
        labels: {
          team: 'prod'
        }
        record: 'job_type:billing_jobs_duration_seconds:99p5m'
      }
    ]
    scopes: [
      account.id
    ]
  }
}
