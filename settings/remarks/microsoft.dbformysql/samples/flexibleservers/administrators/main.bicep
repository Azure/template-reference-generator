param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the MySQL flexible server')
param administratorLoginPassword string

resource userassignedidentity1 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai2'
  location: location
}

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2023-12-30' = {
  name: '${resourceName}-mysql'
  location: location
  sku: {
    tier: 'Burstable'
    name: 'Standard_B1ms'
  }
  properties: {
    dataEncryption: {
      type: 'SystemManaged'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    version: '8.0.21'
    administratorLogin: 'tfadmin'
    administratorLoginPassword: '${administratorLoginPassword}'
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
}

resource administrator 'Microsoft.DBforMySQL/flexibleServers/administrators@2023-12-30' = {
  name: 'ActiveDirectory'
  parent: flexibleServer
  properties: {
    identityResourceId: userAssignedIdentity.id
    login: 'sqladmin'
    sid: deployer().objectId
    tenantId: tenant()
    administratorType: 'ActiveDirectory'
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai1'
  location: location
}
