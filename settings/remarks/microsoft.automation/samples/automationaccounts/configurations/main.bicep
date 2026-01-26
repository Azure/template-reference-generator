param resourceName string = 'acctest0001'
param location string = 'westeurope'

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

resource configuration 'Microsoft.Automation/automationAccounts/configurations@2022-08-08' = {
  parent: automationAccount
  name: resourceName
  location: location
  properties: {
    description: 'test'
    logVerbose: false
    source: {
      type: 'embeddedContent'
      value: 'configuration acctest {}'
    }
  }
  tags: {
    ENV: 'prod'
  }
}
