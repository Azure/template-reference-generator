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
    customPersistentDisks: []
    enableEndToEndTLS: false
    public: false
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

resource linker 'Microsoft.ServiceLinker/linkers@2022-05-01' = {
  name: resourceName
  scope: deployment
  properties: {
    clientType: 'none'
    targetService: {
      resourceProperties: null
      type: 'AzureResource'
    }
    authInfo: {
      authType: 'systemAssignedIdentity'
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
    defaultIdentity: 'FirstPartyIdentity'
    disableLocalAuth: false
    ipRules: []
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    disableKeyBasedMetadataWriteAccess: false
    capabilities: []
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
    virtualNetworkRules: []
    databaseAccountOfferType: 'Standard'
    enableAnalyticalStorage: false
    enableAutomaticFailover: false
    enableFreeTier: false
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
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
