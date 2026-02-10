param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    networkAclBypassResourceIds: []
    virtualNetworkRules: []
    capabilities: []
    defaultIdentity: 'FirstPartyIdentity'
    enableAutomaticFailover: false
    enableFreeTier: false
    ipRules: []
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    enableAnalyticalStorage: false
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    disableLocalAuth: false
    isVirtualNetworkFilterEnabled: false
    databaseAccountOfferType: 'Standard'
    disableKeyBasedMetadataWriteAccess: false
    enableMultipleWriteLocations: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
    }
  }
}

resource container 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  name: resourceName
  parent: sqlDatabase
  properties: {
    options: {}
    resource: {
      id: '${resourceName}'
      partitionKey: {
        paths: [
          '/definition/id'
        ]
        kind: 'Hash'
      }
    }
  }
}

resource storedProcedure 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/storedProcedures@2021-10-15' = {
  name: resourceName
  parent: container
  properties: {
    options: {}
    resource: {
      body: '''  	function () {
		var context = getContext();
		var response = context.getResponse();
		response.setBody(''Hello, World'');
	}
'''
      id: '${resourceName}'
    }
  }
}
