param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isHnsEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
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
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
  }
}

resource localUser 'Microsoft.Storage/storageAccounts/localUsers@2021-09-01' = {
  name: resourceName
  parent: storageAccount
  properties: {
    hasSshPassword: false
    homeDirectory: 'containername/'
    permissionScopes: [
      {
        service: 'blob'
        permissions: 'cwl'
        resourceName: 'containername'
      }
    ]
    hasSharedKey: true
    hasSshKey: false
  }
}
