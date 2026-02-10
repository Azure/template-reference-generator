targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'westus'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: resourceName
  location: location
}

resource budget 'Microsoft.Consumption/budgets@2019-10-01' = {
  name: resourceName
  properties: {
    amount: 1000
    category: 'Cost'
    filter: {
      tags: {
        name: 'foo'
        operator: 'In'
        values: [
          'bar'
        ]
      }
    }
    notifications: {
      'Actual_EqualTo_90.000000_Percent': {
        enabled: true
        operator: 'EqualTo'
        threshold: 90
        thresholdType: 'Actual'
        contactEmails: [
          'foo@example.com'
          'bar@example.com'
        ]
        contactGroups: []
        contactRoles: []
      }
    }
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: '2025-08-01T00:00:00Z'
    }
  }
}
