param resourceName string = 'acctest0002'
param location string = 'westeurope'

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
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
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
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
  }
  tags: {
    environment: 'production'
  }
}

resource updateAdvancedthreatprotectionsetting 'Microsoft.Security/advancedThreatProtectionSettings@2019-01-01' = {
  name: 'current'
  scope: storageAccount
  properties: {
    isEnabled: true
  }
}
