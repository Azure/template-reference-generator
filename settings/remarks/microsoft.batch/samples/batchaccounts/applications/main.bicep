param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    autoStorage: {
      authenticationMode: 'StorageKeys'
      storageAccountId: storageAccount.id
    }
    encryption: {
      keySource: 'Microsoft.Batch'
    }
    poolAllocationMode: 'BatchService'
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
}

resource application 'Microsoft.Batch/batchAccounts/applications@2022-10-01' = {
  name: resourceName
  parent: batchAccount
  properties: {
    allowUpdates: true
    defaultVersion: ''
    displayName: ''
  }
}
