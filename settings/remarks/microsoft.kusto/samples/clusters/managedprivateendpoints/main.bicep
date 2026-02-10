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
    enableDiskEncryption: false
    enablePurge: false
    engineType: 'V2'
    publicIPType: 'IPv4'
    publicNetworkAccess: 'Enabled'
    trustedExternalTenants: []
    enableDoubleEncryption: false
    enableStreamingIngest: false
    restrictOutboundNetworkAccess: 'Disabled'
    enableAutoStop: true
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
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isNfsV3Enabled: false
  }
}
