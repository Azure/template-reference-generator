param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('GitHub Personal Access Token')
param pat string

resource automationAccount 'Microsoft.Automation/automationAccounts@2023-11-01' = {
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

resource sourceControl 'Microsoft.Automation/automationAccounts/sourceControls@2023-11-01' = {
  parent: automationAccount
  name: resourceName
  properties: {
    autoSync: false
    branch: 'master'
    folderPath: '/'
    publishRunbook: false
    repoUrl: 'https://github.com/Azure-Samples/acr-build-helloworld-node.git'
    securityToken: {
      accessToken: null
      tokenType: 'PersonalAccessToken'
    }
    sourceType: 'GitHub'
  }
}
