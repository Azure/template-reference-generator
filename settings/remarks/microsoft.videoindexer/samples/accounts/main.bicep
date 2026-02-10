param resourceName string = 'acctest0001'
param location string = 'westus'

resource account 'Microsoft.VideoIndexer/accounts@2025-04-01' = {
  name: '${resourceName}-vi'
  location: location
  properties: {
    storageServices: {
      userAssignedIdentity: ''
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${replace(resourceName, '-', '')}sa'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultToOAuthAuthentication: false
    isSftpEnabled: false
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    dnsEndpointType: 'Standard'
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
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    isHnsEnabled: false
    isLocalUserEnabled: true
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-identity'
  location: location
}
