param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource vault 'Microsoft.RecoveryServices/vaults@2022-10-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2023-02-01' = {
  name: resourceName
  parent: vault
  properties: {
    backupManagementType: 'AzureStorage'
    retentionPolicy: {
      dailySchedule: {
        retentionDuration: {
          count: 10
          durationType: 'Days'
        }
        retentionTimes: [
          '2018-07-30T23:00:00Z'
        ]
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    schedulePolicy: {
      schedulePolicyType: 'SimpleSchedulePolicy'
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: [
        '2018-07-30T23:00:00Z'
      ]
    }
    timeZone: 'UTC'
    workLoadType: 'AzureFileShare'
  }
}
