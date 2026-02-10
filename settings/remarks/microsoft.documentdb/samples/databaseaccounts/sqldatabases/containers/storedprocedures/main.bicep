param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    ipRules: []
    networkAclBypass: 'None'
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    capabilities: []
    disableKeyBasedMetadataWriteAccess: false
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypassResourceIds: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    enableAutomaticFailover: false
    defaultIdentity: 'FirstPartyIdentity'
    enableAnalyticalStorage: false
    enableFreeTier: false
    enableMultipleWriteLocations: false
    isVirtualNetworkFilterEnabled: false
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
      partitionKey: {
        kind: 'Hash'
        paths: [
          '/definition/id'
        ]
      }
      id: '${resourceName}'
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
