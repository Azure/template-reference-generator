param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The password for the automation account credential')
param credentialPassword string

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    encryption: {
      keySource: 'Microsoft.Automation'
    }
    publicNetworkAccess: true
    sku: {
      name: 'Basic'
    }
  }
}

resource credential 'Microsoft.Automation/automationAccounts/credentials@2020-01-13-preview' = {
  name: resourceName
  parent: automationAccount
  properties: {
    userName: 'test_user'
    description: ''
    password: '${credentialPassword}'
  }
}

resource hybridRunbookWorkerGroup 'Microsoft.Automation/automationAccounts/hybridRunbookWorkerGroups@2021-06-22' = {
  name: resourceName
  parent: automationAccount
}
