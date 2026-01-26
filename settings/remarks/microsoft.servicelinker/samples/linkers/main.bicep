param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  properties: {
    zoneRedundant: false
  }
  sku: {
    name: 'S0'
  }
}

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    capabilities: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    ipRules: []
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
  }
}

resource linker 'Microsoft.ServiceLinker/linkers@2022-05-01' = {
  scope: deployment
  name: resourceName
  properties: {
    authInfo: {
      authType: 'systemAssignedIdentity'
    }
    clientType: 'none'
    targetService: {
      id: sqlDatabase.id
      resourceProperties: null
      type: 'AzureResource'
    }
  }
}

resource app 'Microsoft.AppPlatform/Spring/apps@2023-05-01-preview' = {
  parent: spring
  name: resourceName
  location: location
  properties: {
    customPersistentDisks: []
    enableEndToEndTLS: false
    public: false
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  parent: databaseAccount
  name: resourceName
  properties: {
    options: {
      throughput: 400
    }
    resource: {
      id: 'acctest0001'
    }
  }
}

resource deployment 'Microsoft.AppPlatform/Spring/apps/deployments@2023-05-01-preview' = {
  parent: app
  name: 'deploy-q4uff'
  properties: {
    deploymentSettings: {
      environmentVariables: {}
      resourceRequests: {
        cpu: '1'
        memory: '1Gi'
      }
    }
    source: {
      jvmOptions: ''
      relativePath: '<default>'
      runtimeVersion: 'Java_8'
      type: 'Jar'
    }
  }
  sku: {
    capacity: 1
    name: 'S0'
    tier: 'Standard'
  }
}
