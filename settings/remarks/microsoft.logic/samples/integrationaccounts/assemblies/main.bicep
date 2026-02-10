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
    allowBlobPublicAccess: true
    isHnsEnabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
      bypass: 'AzureServices'
      defaultAction: 'Allow'
    }
    allowCrossTenantReplication: false
    isLocalUserEnabled: true
    accessTier: 'Hot'
    allowSharedKeyAccess: true
    defaultToOAuthAuthentication: false
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
    isSftpEnabled: false
  }
}

resource assembly 'Microsoft.Logic/integrationAccounts/assemblies@2019-05-01' = {
  name: '${resourceName}-assembly'
  parent: integrationAccount
  properties: {
    content: 'dGVzdA=='
    contentType: 'application/octet-stream'
    metadata: {
      foo: 'bar2'
    }
    assemblyName: 'TestAssembly2'
    assemblyVersion: '2.2.2.2'
  }
}
