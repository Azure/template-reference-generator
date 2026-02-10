param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource databaseAccount 'Microsoft.DocumentDB/databaseAccounts@2021-10-15' = {
  name: resourceName
  location: location
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    disableLocalAuth: false
    isVirtualNetworkFilterEnabled: false
    defaultIdentity: 'FirstPartyIdentity'
    locations: [
      {
        failoverPriority: 0
        isZoneRedundant: false
        locationName: 'West Europe'
      }
    ]
    networkAclBypass: 'None'
    capabilities: []
    disableKeyBasedMetadataWriteAccess: false
    enableAutomaticFailover: false
    enableFreeTier: false
    publicNetworkAccess: 'Enabled'
    virtualNetworkRules: []
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
      maxIntervalInSeconds: 5
      maxStalenessPrefix: 100
    }
    enableAnalyticalStorage: false
    enableMultipleWriteLocations: false
    ipRules: []
    networkAclBypassResourceIds: []
  }
}

resource sqlDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2021-10-15' = {
  name: resourceName
  parent: databaseAccount
  properties: {
    resource: {
      id: '${resourceName}'
    }
    options: {}
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
        kind: 'Hash'
        paths: [
          '/definition/id'
        ]
      }
    }
  }
}

resource userDefinedFunction 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers/userDefinedFunctions@2021-10-15' = {
  name: resourceName
  parent: container
  properties: {
    options: {}
    resource: {
      body: '''  	function test() {
		var context = getContext();
		var response = context.getResponse();
		response.setBody(''Hello, World'');
	}
'''
      id: '${resourceName}'
    }
  }
}
