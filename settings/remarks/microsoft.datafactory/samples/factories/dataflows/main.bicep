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
            parameters: {}
            type: 'LinkedServiceReference'
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

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
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
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    isNfsV3Enabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
  }
}
