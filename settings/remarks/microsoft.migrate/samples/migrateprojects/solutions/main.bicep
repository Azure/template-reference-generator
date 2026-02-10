param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource project 'Microsoft.Migrate/migrateProjects@2020-05-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    encryption: {
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
      keySource: 'Microsoft.Storage'
    }
    isHnsEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
  }
}

resource solution 'Microsoft.Migrate/migrateProjects/solutions@2018-09-01-preview' = {
  name: resourceName
  parent: project
  properties: {
    summary: {
      instanceType: 'Servers'
      migratedCount: 0
    }
  }
}
