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

resource module 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  parent: automationAccount
  name: 'xActiveDirectory'
  properties: {
    contentLink: {
      uri: 'https://devopsgallerystorage.blob.core.windows.net/packages/xactivedirectory.2.19.0.nupkg'
    }
  }
}
