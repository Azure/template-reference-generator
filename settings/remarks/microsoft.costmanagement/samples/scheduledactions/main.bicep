targetScope = 'subscription'

param location string = 'eastus'
param resourceName string = 'acctest0001'

resource scheduledAction 'Microsoft.CostManagement/scheduledActions@2022-10-01' = {
  name: resourceName
  scope: subscription()
  kind: 'Email'
  properties: {
    viewId: resourceId('Microsoft.CostManagement/views', 'ms:CostByService')
    displayName: 'CostByServiceViewerz3k'
    fileDestination: {
      fileFormats: []
    }
    notification: {
      subject: 'Cost Management Report for Terraform Testing on Azure with TTL = 2 Day'
      to: [
        'test@test.com'
        'hashicorp@test.com'
      ]
      message: ''
    }
    notificationEmail: 'test@test.com'
    schedule: {
      dayOfMonth: 0
      daysOfWeek: null
      endDate: '2023-07-02T00:00:00Z'
      frequency: 'Daily'
      hourOfDay: 0
      startDate: '2023-07-01T00:00:00Z'
      weeksOfMonth: null
    }
    status: 'Enabled'
  }
}
