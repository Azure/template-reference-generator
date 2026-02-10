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

resource runbook 'Microsoft.Automation/automationAccounts/runbooks@2019-06-01' = {
  name: 'Get-AzureVMTutorial'
  location: location
  parent: automationAccount
  properties: {
    logVerbose: true
    runbookType: 'PowerShell'
    description: 'This is a test runbook for terraform acceptance test'
    draft: {}
    logActivityTrace: 0
    logProgress: true
  }
}

resource draft 'Microsoft.Automation/automationAccounts/runbooks/draft@2018-06-30' = {
  name: 'content'
  parent: runbook
}
