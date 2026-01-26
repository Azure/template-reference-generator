param resourceName string = 'acctest0001'
param location string = 'westus'

resource integrationAccount 'Microsoft.Logic/integrationAccounts@2019-05-01' = {
  name: '${resourceName}-ia'
  location: location
  properties: {}
  sku: {
    name: 'Standard'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: replace(substring(toLower('${resourceName}sa'), 0, 24), '-', '')
  location: location
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
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
    isHnsEnabled: false
    isLocalUserEnabled: true
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
  sku: {
    name: 'Standard_LRS'
  }
}

resource assembly 'Microsoft.Logic/integrationAccounts/assemblies@2019-05-01' = {
  parent: integrationAccount
  name: '${resourceName}-assembly'
  properties: {
    assemblyName: 'TestAssembly2'
    assemblyVersion: '2.2.2.2'
    content: 'dGVzdA=='
    contentType: 'application/octet-stream'
    metadata: {
      foo: 'bar2'
    }
  }
}
