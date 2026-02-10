param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource spring 'Microsoft.AppPlatform/Spring@2023-05-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'S0'
  }
  properties: {
    zoneRedundant: false
  }
}

resource app 'Microsoft.AppPlatform/Spring/apps@2023-05-01-preview' = {
  name: resourceName
  location: location
  parent: spring
  properties: {
    enableEndToEndTLS: false
    public: false
    customPersistentDisks: []
  }
}

resource deployment 'Microsoft.AppPlatform/Spring/apps/deployments@2023-05-01-preview' = {
  name: 'deploy-q4uff'
  parent: app
  sku: {
    capacity: 1
    name: 'S0'
    tier: 'Standard'
  }
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
}

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    consistencyPolicy: {
      defaultConsistencyLevel: 'BoundedStaleness'
      maxIntervalInSeconds: 10
      maxStalenessPrefix: 200
    }
    enableAnalyticalStorage: false
    isVirtualNetworkFilterEnabled: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    defaultIdentity: 'FirstPartyIdentity'
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableFreeTier: false
    ipRules: []
    networkAclBypass: 'None'
    networkAclBypassResourceIds: []
    publicNetworkAccess: 'Enabled'
    capabilities: []
    enableMultipleWriteLocations: false
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    virtualNetworkRules: []
  }
}

resource linker 'Microsoft.ServiceLinker/linkers@2022-05-01' = {
  name: resourceName
  scope: deployment
  properties: {
    authInfo: {
      authType: 'systemAssignedIdentity'
    }
    clientType: 'none'
    targetService: {
      resourceProperties: null
      type: 'AzureResource'
    }
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {
      throughput: 400
    }
    resource: {
      id: '${resourceName}'
    }
  }
}
