param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource prometheusRuleGroup 'Microsoft.AlertsManagement/prometheusRuleGroups@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    scopes: [
      account.id
    ]
    clusterName: ''
    description: ''
    enabled: false
    rules: [
      {
        labels: {
          team: 'prod'
        }
        record: 'job_type:billing_jobs_duration_seconds:99p5m'
        enabled: false
        expression: '''histogram_quantile(0.99, sum(rate(jobs_duration_seconds_bucket{service="billing-processing"}[5m])) by (job_type))
'''
      }
    ]
  }
}

resource account 'Microsoft.Monitor/accounts@2023-04-03' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}
