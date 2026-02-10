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
    publicNetworkAccess: 'Enabled'
    defaultToOAuthAuthentication: false
    isLocalUserEnabled: true
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: []
      resourceAccessRules: []
      virtualNetworkRules: []
    }
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    encryption: {
      services: {
        queue: {
          keyType: 'Service'
        }
        table: {
          keyType: 'Service'
        }
      }
      keySource: 'Microsoft.Storage'
    }
    allowBlobPublicAccess: true
    allowCrossTenantReplication: false
    dnsEndpointType: 'Standard'
    isNfsV3Enabled: false
    minimumTlsVersion: 'TLS1_2'
    allowSharedKeyAccess: true
    isHnsEnabled: false
    isSftpEnabled: false
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
      enableHealthCheck: false
      excludeFromLatest: false
      manageActions: {
        install: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        remove: /* ERROR: Unparsed HCL syntax in LiteralNode */ {}
        update: ''
      }
      source: {
        defaultConfigurationLink: ''
        mediaLink: 'https://${storageAccount.name}.blob.core.windows.net/mycontainer/myblob'
      }
      targetRegions: [
        {
          regionalReplicaCount: 1
          storageAccountType: 'Standard_LRS'
          name: location
        }
      ]
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
}
