param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource managedEnvironment 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: resourceName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        sharedKey: workspace.listKeys().primarySharedKey
      }
    }
    vnetConfiguration: {}
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
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    accessTier: 'Hot'
    isHnsEnabled: false
    isNfsV3Enabled: false
    isSftpEnabled: false
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: true
  }
  tags: {
    environment: 'accTest'
  }
}

resource workspace 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: resourceName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: -1
    }
    features: {
      disableLocalAuth: false
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    retentionInDays: 30
  }
}

resource storage 'Microsoft.App/managedEnvironments/storages@2022-03-01' = {
  name: resourceName
  parent: managedEnvironment
  properties: {
    azureFile: {
      shareName: 'testsharehkez7'
      accessMode: 'ReadWrite'
      accountKey: storageAccount.listKeys().keys[0].value
      accountName: storageAccount.name
    }
  }
}
