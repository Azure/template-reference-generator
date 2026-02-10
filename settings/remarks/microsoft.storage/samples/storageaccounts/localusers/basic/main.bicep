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
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
    }
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
  }
}

resource localUser 'Microsoft.Storage/storageAccounts/localUsers@2021-09-01' = {
  name: resourceName
  parent: storageAccount
  properties: {
    homeDirectory: 'containername/'
    permissionScopes: [
      {
        resourceName: 'containername'
        service: 'blob'
        permissions: 'cwl'
      }
    ]
    hasSharedKey: true
    hasSshKey: false
    hasSshPassword: false
  }
}
