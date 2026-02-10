param location string = 'westeurope'
param resourceName string = 'acctest0001'

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

resource softwareUpdateConfiguration 'Microsoft.Automation/automationAccounts/softwareUpdateConfigurations@2019-06-01' = {
  name: resourceName
  parent: automationAccount
  properties: {
    scheduleInfo: {
      description: ''
      expiryTimeOffsetMinutes: 0
      frequency: 'OneTime'
      interval: 0
      isEnabled: true
      nextRunOffsetMinutes: 0
      startTimeOffsetMinutes: 0
      timeZone: 'Etc/UTC'
    }
    updateConfiguration: {
      duration: 'PT2H'
      linux: {
        excludedPackageNameMasks: []
        includedPackageClassifications: 'Security'
        includedPackageNameMasks: []
        rebootSetting: 'IfRequired'
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
