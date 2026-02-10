param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource backupVault 'Microsoft.DataProtection/backupVaults@2022-04-01' = {
  name: resourceName
  location: location
  properties: {
    storageSettings: [
      {
        datastoreType: 'VaultStore'
        type: 'LocallyRedundant'
      }
    ]
  }
}

resource backupPolicy 'Microsoft.DataProtection/backupVaults/backupPolicies@2022-04-01' = {
  name: resourceName
  parent: backupVault
  properties: {
    datasourceTypes: [
      'Microsoft.DBforPostgreSQL/servers/databases'
    ]
    objectType: 'BackupPolicy'
    policyRules: [
      {
        name: 'BackupIntervals'
        objectType: 'AzureBackupRule'
        trigger: {
          objectType: 'ScheduleBasedTriggerContext'
          schedule: {
            repeatingTimeIntervals: [
              'R/2021-05-23T02:30:00+00:00/P1W'
            ]
          }
          taggingCriteria: [
            {
              isDefault: true
              tagInfo: {
                id: 'Default_'
                tagName: 'Default'
              }
              taggingPriority: 99
            }
          ]
        }
        backupParameters: {
          backupType: 'Full'
          objectType: 'AzureBackupParams'
        }
        dataStore: {
          dataStoreType: 'VaultStore'
          objectType: 'DataStoreInfoBase'
        }
      }
      {
        objectType: 'AzureRetentionRule'
        isDefault: true
        lifecycles: [
          {
            targetDataStoreCopySettings: []
            deleteAfter: {
              duration: 'P4M'
              objectType: 'AbsoluteDeleteOption'
            }
            sourceDataStore: {
              objectType: 'DataStoreInfoBase'
              dataStoreType: 'VaultStore'
            }
          }
        ]
        name: 'Default'
      }
    ]
  }
}
