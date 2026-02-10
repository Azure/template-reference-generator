param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: true
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
    }
  }
}

resource configuration 'Microsoft.Automation/automationAccounts/configurations@2022-08-08' = {
  name: resourceName
  location: location
  parent: automationAccount
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
