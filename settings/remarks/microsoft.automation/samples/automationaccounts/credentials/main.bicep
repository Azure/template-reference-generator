param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The password for the automation account credential')
param automationCredentialPassword string

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
  parent: automationAccount
  name: resourceName
  properties: {
    description: ''
    password: null
    userName: 'test_user'
  }
}
