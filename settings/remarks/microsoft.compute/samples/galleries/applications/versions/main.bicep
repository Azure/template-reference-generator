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

resource application 'Microsoft.Compute/galleries/applications@2022-03-03' = {
  parent: gallery
  name: '${resourceName}-app'
  location: location
  properties: {
    supportedOSType: 'Linux'
  }
}

// The blob service is a singleton named 'default' under the storage account
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-05-01' existing = {
  parent: storageAccount
  name: 'default'
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-05-01' = {
  parent: blobService
  name: 'mycontainer'
  properties: {
    publicAccess: 'Blob'
  }
}

resource version 'Microsoft.Compute/galleries/applications/versions@2022-03-03' = {
  parent: application
  name: '0.0.1'
  location: location
  properties: {
    publishingProfile: {
      enableHealthCheck: false
      excludeFromLatest: false
      manageActions: {
        install: '[install command]'
        remove: '[remove command]'
        update: ''
      }
      source: {
        defaultConfigurationLink: ''
        mediaLink: 'https://${storageAccount.name}.blob.core.windows.net/mycontainer/myblob'
      }
      targetRegions: [
        {
          name: 'westus'
          regionalReplicaCount: 1
          storageAccountType: 'Standard_LRS'
        }
      ]
    }
    safetyProfile: {
      allowDeletionOfReplicatedLocations: true
    }
  }
  dependsOn: [
    container
  ]
}
