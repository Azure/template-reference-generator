param resourceName string = 'acctest0001'
param location string = 'eastus2'

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
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication: true
    defaultToOAuthAuthentication: false
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      defaultAction: 'Allow'
    }
    publicNetworkAccess: 'Enabled'
    allowSharedKeyAccess: true
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource networkWatchers 'Microsoft.Network/networkWatchers@2023-11-01' = {
  name: resourceName
  location: location
  properties: {}
}

resource flowLog 'Microsoft.Network/networkWatchers/flowLogs@2023-11-01' = {
  name: resourceName
  location: location
  parent: networkWatchers
  properties: {
    retentionPolicy: {
      enabled: true
      days: 7
    }
    storageId: storageAccount.id
    targetResourceId: virtualNetwork.id
    enabled: true
    flowAnalyticsConfiguration: {
      networkWatcherFlowAnalyticsConfiguration: {
        enabled: false
      }
    }
    format: {
      type: 'JSON'
      version: 2
    }
  }
}
