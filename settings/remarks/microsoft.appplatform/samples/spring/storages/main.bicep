param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
  }
  properties: {
    zoneRedundant: false
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
  properties: {
    isNfsV3Enabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
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
  }
}

resource storage 'Microsoft.AppPlatform/Spring/storages@2023-05-01-preview' = {
  name: resourceName
  parent: spring
  properties: {
    accountName: storageAccount.name
    storageType: 'StorageAccount'
    accountKey: storageAccount.listKeys().keys[0].value
  }
}
