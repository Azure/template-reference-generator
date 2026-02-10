param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string

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
      }
      {
        lifecycles: [
          {
            sourceDataStore: {
              dataStoreType: 'VaultStore'
              objectType: 'DataStoreInfoBase'
            }
            targetDataStoreCopySettings: []
            deleteAfter: {
              duration: 'P4M'
              objectType: 'AbsoluteDeleteOption'
            }
          }
        ]
        name: 'Default'
        objectType: 'AzureRetentionRule'
        isDefault: true
      }
    ]
    datasourceTypes: [
      'Microsoft.DBforPostgreSQL/servers/databases'
    ]
    objectType: 'BackupPolicy'
  }
}

resource server 'Microsoft.DBforPostgreSQL/servers@2017-12-01' = {
  name: resourceName
  location: location
  sku: {
    capacity: 2
    family: 'Gen5'
    name: 'B_Gen5_2'
    tier: 'Basic'
  }
  properties: {
    infrastructureEncryption: 'Disabled'
    version: '9.5'
    administratorLogin: 'psqladmin'
    minimalTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    sslEnforcement: 'Enabled'
    storageProfile: {
      backupRetentionDays: 7
      storageAutogrow: 'Enabled'
      storageMB: 5120
    }
    administratorLoginPassword: '${administratorLoginPassword}'
    createMode: 'Default'
  }
}

resource database 'Microsoft.DBforPostgreSQL/servers/databases@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    charset: 'UTF8'
    collation: 'English_United States.1252'
  }
}

resource backupInstance 'Microsoft.DataProtection/backupVaults/backupInstances@2022-04-01' = {
  name: resourceName
  parent: backupVault
  properties: {
    dataSourceInfo: {
      datasourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
      objectType: 'Datasource'
      resourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
      resourceUri: ''
    }
    dataSourceSetInfo: {
      resourceID: server.id
      resourceLocation: server.location
      resourceName: server.name
      resourceType: 'Microsoft.DBForPostgreSQL/servers'
      resourceUri: ''
      datasourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
      objectType: 'DatasourceSet'
    }
    datasourceAuthCredentials: null
    friendlyName: resourceName
    objectType: 'BackupInstance'
    policyInfo: {}
  }
}
