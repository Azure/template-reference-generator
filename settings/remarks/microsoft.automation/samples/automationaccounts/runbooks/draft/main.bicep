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
  parent: automationAccount
  name: 'Get-AzureVMTutorial'
  location: location
  properties: {
    description: 'This is a test runbook for terraform acceptance test'
    draft: {}
    logActivityTrace: 0
    logProgress: true
    logVerbose: true
    runbookType: 'PowerShell'
  }
}

resource draft 'Microsoft.Automation/automationAccounts/runbooks/draft@2018-06-30' = {
  parent: runbook
  name: 'content'
}
