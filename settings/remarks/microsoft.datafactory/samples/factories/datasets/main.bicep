param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
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
  }
}

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    repoConfiguration: null
  }
}

resource dataset 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    type: 'Json'
    typeProperties: {
      encodingName: 'UTF-8'
      location: {
        folderPath: 'foo/bar/'
        type: 'AzureBlobStorageLocation'
        container: 'container'
        fileName: 'bar.txt'
      }
    }
    description: ''
    linkedServiceName: {
      type: 'LinkedServiceReference'
    }
  }
}

resource linkedservice 'Microsoft.DataFactory/factories/linkedservices@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    description: ''
    type: 'AzureBlobStorage'
    typeProperties: {
      serviceEndpoint: storageAccount.properties.primaryEndpoints.blob
    }
  }
}
