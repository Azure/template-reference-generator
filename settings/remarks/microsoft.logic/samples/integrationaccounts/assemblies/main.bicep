param resourceName string = 'acctest0001'
param location string = 'westus'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: '${resourceName}-ia'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {}
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: replace(substring(toLower('${resourceName}sa'), 0, 24), '-', '')
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    dnsEndpointType: 'Standard'
    publicNetworkAccess: 'Enabled'
    allowBlobPublicAccess: true
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
    isLocalUserEnabled: true
    supportsHttpsTrafficOnly: true
    allowCrossTenantReplication: false
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
  }
}

resource assembly 'Microsoft.Logic/integrationAccounts/assemblies@2019-05-01' = {
  name: '${resourceName}-assembly'
  parent: integrationAccount
  properties: {
    contentType: 'application/octet-stream'
    metadata: {
      foo: 'bar2'
    }
    assemblyName: 'TestAssembly2'
    assemblyVersion: '2.2.2.2'
    content: 'dGVzdA=='
  }
}
