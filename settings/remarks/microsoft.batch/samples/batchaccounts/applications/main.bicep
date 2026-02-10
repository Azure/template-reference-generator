param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource batchAccount 'Microsoft.Batch/batchAccounts@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    autoStorage: {
      authenticationMode: 'StorageKeys'
    }
    encryption: {
      keySource: 'Microsoft.Batch'
    }
    poolAllocationMode: 'BatchService'
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
