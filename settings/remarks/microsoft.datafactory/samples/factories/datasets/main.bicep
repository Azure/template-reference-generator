param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource factory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: resourceName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
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
    accessTier: 'Hot'
    allowBlobPublicAccess: true
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
    isNfsV3Enabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}

resource dataset 'Microsoft.DataFactory/factories/datasets@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    description: ''
    linkedServiceName: {
      referenceName: linkedservice.name
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
