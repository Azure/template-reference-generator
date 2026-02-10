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

resource softwareUpdateConfiguration 'Microsoft.Automation/automationAccounts/softwareUpdateConfigurations@2019-06-01' = {
  name: resourceName
  parent: automationAccount
  properties: {
    scheduleInfo: {
      nextRunOffsetMinutes: 0
      timeZone: 'Etc/UTC'
      expiryTimeOffsetMinutes: 0
      isEnabled: true
      startTimeOffsetMinutes: 0
      description: ''
      frequency: 'OneTime'
      interval: 0
    }
    updateConfiguration: {
      duration: 'PT2H'
      linux: {
        includedPackageClassifications: 'Security'
        includedPackageNameMasks: []
        rebootSetting: 'IfRequired'
        excludedPackageNameMasks: []
      }
      operatingSystem: 'Linux'
      targets: {
        azureQueries: [
          {
            locations: [
              'westeurope'
            ]
            scope: [
              resourceGroup().id
            ]
          }
        ]
      }
    }
  }
}
