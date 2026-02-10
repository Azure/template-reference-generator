param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the PostgreSQL server')
param administratorLoginPassword string

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
    createMode: 'Default'
    publicNetworkAccess: 'Enabled'
    storageProfile: {
      storageAutogrow: 'Enabled'
      storageMB: 5120
      backupRetentionDays: 7
    }
    version: '9.5'
    administratorLogin: 'psqladmin'
    administratorLoginPassword: '${administratorLoginPassword}'
    infrastructureEncryption: 'Disabled'
    minimalTlsVersion: 'TLS1_2'
    sslEnforcement: 'Enabled'
  }
}

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

resource backupInstance 'Microsoft.DataProtection/backupVaults/backupInstances@2022-04-01' = {
  name: resourceName
  parent: backupVault
  properties: {
    dataSourceSetInfo: {
      resourceUri: ''
      datasourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
      objectType: 'DatasourceSet'
      resourceID: server.id
      resourceLocation: server.location
      resourceName: server.name
      resourceType: 'Microsoft.DBForPostgreSQL/servers'
    }
    datasourceAuthCredentials: null
    friendlyName: resourceName
    objectType: 'BackupInstance'
    policyInfo: {}
    dataSourceInfo: {
      objectType: 'Datasource'
      resourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
      resourceUri: ''
      datasourceType: 'Microsoft.DBforPostgreSQL/servers/databases'
    }
  }
}

resource backupPolicy 'Microsoft.DataProtection/backupVaults/backupPolicies@2022-04-01' = {
  name: resourceName
  parent: backupVault
  properties: {
    policyRules: [
      {
        backupParameters: {
          backupType: 'Full'
          objectType: 'AzureBackupParams'
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
              tagInfo: {
                id: 'Default_'
                tagName: 'Default'
              }
              taggingPriority: 99
              isDefault: true
            }
          ]
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
              objectType: 'DataStoreInfoBase'
              dataStoreType: 'VaultStore'
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

resource database 'Microsoft.DBforPostgreSQL/servers/databases@2017-12-01' = {
  name: resourceName
  parent: server
  properties: {
    charset: 'UTF8'
    collation: 'English_United States.1252'
  }
}
