param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    isHnsEnabled: false
    isSftpEnabled: false
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    encryption: {
      services: {
        table: {
          keyType: 'Service'
        }
        queue: {
          keyType: 'Service'
        }
      }
      keySource: 'Microsoft.Storage'
    }
    isNfsV3Enabled: false
    networkAcls: {
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
  }
}

resource storageInsightConfig 'Microsoft.OperationalInsights/workspaces/storageInsightConfigs@2020-08-01' = {
  name: resourceName
  parent: workspace
  properties: {
    storageAccount: {
      id: storageAccount.id
      key: storageAccount.listKeys().keys[0].value
    }
  }
}
