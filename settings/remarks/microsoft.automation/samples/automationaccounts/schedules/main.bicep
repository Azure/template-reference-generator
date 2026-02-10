param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
    }
    publicNetworkAccess: true
  }
}

resource schedule 'Microsoft.Automation/automationAccounts/schedules@2020-01-13-preview' = {
  name: resourceName
  parent: automationAccount
  properties: {
    description: ''
    frequency: 'OneTime'
    startTime: '2024-07-05T08:51:00+00:00'
    timeZone: 'Etc/UTC'
  }
}
