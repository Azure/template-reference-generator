param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource project 'Microsoft.Migrate/migrateProjects@2020-05-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    utilityStorageAccountId: storageAccount.id
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
    }
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}

resource solution 'Microsoft.Migrate/migrateProjects/solutions@2018-09-01-preview' = {
  parent: project
  name: resourceName
  properties: {
    summary: {
      instanceType: 'Servers'
      migratedCount: 0
    }
  }
}
