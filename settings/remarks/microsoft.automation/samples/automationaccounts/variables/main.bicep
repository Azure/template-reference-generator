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

resource variable 'Microsoft.Automation/automationAccounts/variables@2020-01-13-preview' = {
  name: resourceName
  parent: automationAccount
  properties: {
    description: ''
    isEncrypted: false
    value: 'Hello, Terraform Basic Test.'
  }
}
