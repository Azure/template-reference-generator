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
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
  }
}
