param resourceName string = 'acctest0001'
param location string = 'westus'

resource gallery 'Microsoft.Compute/galleries@2022-03-03' = {
  name: '${resourceName}sig'
  location: location
  properties: {
    description: ''
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: '${resourceName}acc'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    isLocalUserEnabled: true
    minimumTlsVersion: 'TLS1_2'
    isNfsV3Enabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    supportsHttpsTrafficOnly: true
    allowCrossTenantReplication: false
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    allowBlobPublicAccess: true
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
  }
}

resource application 'Microsoft.Compute/galleries/applications@2022-03-03' = {
  name: '${resourceName}-app'
  location: location
  parent: gallery
  properties: {
    supportedOSType: 'Linux'
  }
}

resource storageaccountBlobservices 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' = {
  name: 'default'
  parent: storageAccount
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  name: 'mycontainer'
  parent: storageaccountBlobservices
  properties: {
    publicAccess: 'Blob'
  }
}

resource version 'Microsoft.Compute/galleries/applications/versions@2022-03-03' = {
  name: '0.0.1'
  location: location
  parent: application
  dependsOn: [
    container
  ]
  properties: {
    publishingProfile: {
      source: {
        defaultConfigurationLink: ''
        mediaLink: 'https://${storageAccount.name}.blob.core.windows.net/mycontainer/myblob'
      }
      targetRegions: [
        {
          name: location
          regionalReplicaCount: 1
          storageAccountType: 'Standard_LRS'
        }
      ]
      enableHealthCheck: false
      excludeFromLatest: false
      manageActions: {
        install: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        remove: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        update: ''
      }
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
}
