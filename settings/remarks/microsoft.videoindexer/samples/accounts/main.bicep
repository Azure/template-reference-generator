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
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
    isLocalUserEnabled: true
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
    }
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
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
    publicNetworkAccess: 'Enabled'
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-identity'
  location: location
}
