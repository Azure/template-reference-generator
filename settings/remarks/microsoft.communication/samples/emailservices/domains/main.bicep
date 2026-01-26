param resourceName string = 'acctest0001'

resource emailService 'Microsoft.Communication/emailServices@2023-04-01-preview' = {
  name: resourceName
  location: 'global'
  properties: {
    dataLocation: 'United States'
  }
}

resource domain 'Microsoft.Communication/emailServices/domains@2023-04-01-preview' = {
  parent: emailService
  name: 'example.com'
  location: 'global'
  properties: {
    domainManagement: 'CustomerManaged'
    userEngagementTracking: 'Disabled'
  }
}
