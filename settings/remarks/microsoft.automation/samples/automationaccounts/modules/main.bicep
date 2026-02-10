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

resource module 'Microsoft.Automation/automationAccounts/modules@2020-01-13-preview' = {
  name: 'xActiveDirectory'
  parent: automationAccount
  properties: {
    contentLink: {
      uri: 'https://devopsgallerystorage.blob.core.windows.net/packages/xactivedirectory.2.19.0.nupkg'
    }
  }
}
