param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource backupVault 'Microsoft.DataProtection/backupVaults@2022-04-01' = {
  name: resourceName
  location: location
  properties: {
    storageSettings: [
      {
        type: 'LocallyRedundant'
        datastoreType: 'VaultStore'
      }
    ]
  }
}

resource backupPolicy 'Microsoft.DataProtection/backupVaults/backupPolicies@2022-04-01' = {
  name: resourceName
  parent: backupVault
  properties: {
    policyRules: [
      {
        backupParameters: {
          objectType: 'AzureBackupParams'
          backupType: 'Full'
        }
        dataStore: {
          dataStoreType: 'VaultStore'
          objectType: 'DataStoreInfoBase'
        }
        name: 'BackupIntervals'
        objectType: 'AzureBackupRule'
        trigger: {
          taggingCriteria: [
            {
              tagInfo: {
                id: 'Default_'
                tagName: 'Default'
              }
              taggingPriority: 99
              isDefault: true
            }
          ]
          objectType: 'ScheduleBasedTriggerContext'
          schedule: {
            repeatingTimeIntervals: [
              'R/2021-05-23T02:30:00+00:00/P1W'
            ]
          }
        }
      }
      {
        isDefault: true
        lifecycles: [
          {
            deleteAfter: {
              duration: 'P4M'
              objectType: 'AbsoluteDeleteOption'
            }
            sourceDataStore: {
              dataStoreType: 'VaultStore'
              objectType: 'DataStoreInfoBase'
            }
            targetDataStoreCopySettings: []
          }
        ]
        name: 'Default'
        objectType: 'AzureRetentionRule'
      }
    ]
    datasourceTypes: [
      'Microsoft.DBforPostgreSQL/servers/databases'
    ]
    objectType: 'BackupPolicy'
  }
}
