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
    enableFreeTier: false
    enableMultipleWriteLocations: false
    networkAclBypassResourceIds: []
    databaseAccountOfferType: 'Standard'
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    isVirtualNetworkFilterEnabled: false
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    capabilities: []
    networkAclBypass: 'None'
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    disableKeyBasedMetadataWriteAccess: false
    disableLocalAuth: false
    ipRules: []
  }
}

resource app 'Microsoft.AppPlatform/Spring/apps@2023-05-01-preview' = {
  name: resourceName
  location: location
  parent: spring
  properties: {
    customPersistentDisks: []
    enableEndToEndTLS: false
    public: false
  }
}

resource deployment 'Microsoft.AppPlatform/Spring/apps/deployments@2023-05-01-preview' = {
  name: 'deploy-q4uff'
  parent: app
  sku: {
    name: 'S0'
    tier: 'Standard'
    capacity: 1
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
