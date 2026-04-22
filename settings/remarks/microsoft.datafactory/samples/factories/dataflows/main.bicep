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
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
    }
    isSftpEnabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowCrossTenantReplication: true
    allowSharedKeyAccess: true
  }
}

resource dataflow 'Microsoft.DataFactory/factories/dataflows@2018-06-01' = {
  name: resourceName
  parent: factory
  properties: {
    description: ''
    type: 'Flowlet'
    typeProperties: {
      script: '''source(
  allowSchemaDrift: true, 
  validateSchema: false, 
  limit: 100, 
  ignoreNoFilesFound: false, 
  documentForm: ''documentPerLine'') ~> source1 
source1 sink(
  allowSchemaDrift: true, 
  validateSchema: false, 
  skipDuplicateMapInputs: true, 
  skipDuplicateMapOutputs: true) ~> sink1
'''
      sinks: [
        {
          description: ''
          linkedService: {
            type: 'LinkedServiceReference'
            parameters: {}
          }
          name: 'sink1'
        }
      ]
      sources: [
        {
          description: ''
          linkedService: {
            parameters: {}
            type: 'LinkedServiceReference'
          }
          name: 'source1'
        }
      ]
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
