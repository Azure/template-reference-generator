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
              tagInfo: {
                tagName: 'Default'
                id: 'Default_'
              }
              taggingPriority: 99
              isDefault: true
            }
          ]
        }
        backupParameters: {
          backupType: 'Full'
          objectType: 'AzureBackupParams'
        }
        dataStore: {
          objectType: 'DataStoreInfoBase'
          dataStoreType: 'VaultStore'
        }
      }
      {
        isDefault: true
        lifecycles: [
          {
            deleteAfter: {
              objectType: 'AbsoluteDeleteOption'
              duration: 'P4M'
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
  }
}
