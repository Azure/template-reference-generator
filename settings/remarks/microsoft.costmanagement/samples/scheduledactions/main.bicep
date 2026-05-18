targetScope = 'subscription'

param location string = 'eastus'
param resourceName string = 'acctest0001'

resource scheduledAction 'Microsoft.CostManagement/scheduledActions@2022-10-01' = {
  name: resourceName
  scope: subscription()
  kind: 'Email'
  properties: {
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
    notificationEmail: 'test@test.com'
    schedule: {
      dayOfMonth: 0
      endDate: '2023-07-02T00:00:00Z'
      frequency: 'Daily'
      hourOfDay: 0
      startDate: '2023-07-01T00:00:00Z'
    }
    status: 'Enabled'
    viewId: resourceId('Microsoft.CostManagement/views', 'ms:CostByService')
  }
}
