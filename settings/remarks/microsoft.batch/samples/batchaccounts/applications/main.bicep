param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    poolAllocationMode: 'BatchService'
    publicNetworkAccess: 'Enabled'
    autoStorage: {
      authenticationMode: 'StorageKeys'
    }
    encryption: {
      keySource: 'Microsoft.Batch'
    }
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
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
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
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
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
    defaultVersion: ''
    displayName: ''
    allowUpdates: true
  }
}
