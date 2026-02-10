targetScope = 'subscription'

param resourceName string = 'acctest0001'
param location string = 'eastus'

resource scheduledAction 'Microsoft.CostManagement/scheduledActions@2022-10-01' = {
  name: resourceName
  scope: subscription()
  kind: 'Email'
  properties: {
    notificationEmail: 'test@test.com'
    schedule: {
      daysOfWeek: null
      endDate: '2023-07-02T00:00:00Z'
      frequency: 'Daily'
      hourOfDay: 0
      startDate: '2023-07-01T00:00:00Z'
      weeksOfMonth: null
      dayOfMonth: 0
    }
    status: 'Enabled'
    viewId: resourceId('Microsoft.CostManagement/views', 'ms:CostByService')
    displayName: 'CostByServiceViewerz3k'
    fileDestination: {
      fileFormats: []
    }
    notification: {
      message: ''
      subject: 'Cost Management Report for Terraform Testing on Azure with TTL = 2 Day'
      to: [
        'test@test.com'
        'hashicorp@test.com'
      ]
    }
  }
}
