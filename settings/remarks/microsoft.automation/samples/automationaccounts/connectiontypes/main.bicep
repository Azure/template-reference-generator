param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource automationAccount 'Microsoft.Automation/automationAccounts@2021-06-22' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'Basic'
    }
    encryption: {
      keySource: 'Microsoft.Automation'
    }
    publicNetworkAccess: true
  }
}

resource connectionType 'Microsoft.Automation/automationAccounts/connectionTypes@2020-01-13-preview' = {
  name: resourceName
  parent: automationAccount
  properties: {
    fieldDefinitions: {
      my_def: {
        isEncrypted: false
        isOptional: false
        type: 'string'
      }
    }
    isGlobal: false
  }
}
