targetScope = 'subscription'

param resourceName string = 'acctest0001'

resource securityContact 'Microsoft.Security/securityContacts@2017-08-01-preview' = {
  name: resourceName
  properties: {
    alertNotifications: 'On'
    alertsToAdmins: 'On'
    email: 'basic@example.com'
    phone: '+1-555-555-5555'
  }
}
