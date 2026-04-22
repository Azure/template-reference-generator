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
      frequency: 'OneTime'
      startTimeOffsetMinutes: 0
      description: ''
      interval: 0
      isEnabled: true
    }
    updateConfiguration: {
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
      duration: 'PT2H'
      linux: {
        excludedPackageNameMasks: []
        includedPackageClassifications: 'Security'
        includedPackageNameMasks: []
        rebootSetting: 'IfRequired'
      }
    }
  }
}
