param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.Kusto/clusters@2023-05-02' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Dev(No SLA)_Standard_D11_v2'
    tier: 'Basic'
  }
  properties: {
    enablePurge: false
    engineType: 'V2'
    publicIPType: 'IPv4'
    restrictOutboundNetworkAccess: 'Disabled'
    trustedExternalTenants: []
    enableAutoStop: true
    enableDiskEncryption: false
    enableDoubleEncryption: false
    enableStreamingIngest: false
    publicNetworkAccess: 'Enabled'
  }
}

resource managedPrivateEndpoint 'Microsoft.Kusto/clusters/managedPrivateEndpoints@2023-05-02' = {
  name: resourceName
  parent: cluster
  properties: {
    groupId: 'blob'
    privateLinkResourceId: storageAccount.id
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
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
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
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
    isHnsEnabled: false
  }
}
