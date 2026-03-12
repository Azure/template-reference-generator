param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    repoConfiguration: null
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
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowSharedKeyAccess: true
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
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
  }
}

resource dataset 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    description: ''
    linkedServiceName: {
      type: 'LinkedServiceReference'
    }
    type: 'Json'
    typeProperties: {
      encodingName: 'UTF-8'
      location: {
        container: 'container'
        fileName: 'bar.txt'
        folderPath: 'foo/bar/'
        type: 'AzureBlobStorageLocation'
      }
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
