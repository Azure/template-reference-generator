param location string = 'westus'
@secure()
@description('The administrator login password for the MySQL flexible server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource flexibleServer 'Microsoft.DBforMySQL/flexibleServers@2023-12-30' = {
  name: '${resourceName}-mysql'
  location: location
  sku: {
    tier: 'Burstable'
    name: 'Standard_B1ms'
  }
  properties: {
    administratorLogin: 'tfadmin'
    administratorLoginPassword: '${administratorLoginPassword}'
    backup: {
      geoRedundantBackup: 'Disabled'
      backupRetentionDays: 7
    }
    dataEncryption: {
      type: 'SystemManaged'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    version: '8.0.21'
  }
}

resource userAssignedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai1'
  location: location
}

resource userassignedidentity1 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: '${resourceName}-uai2'
  location: location
}

resource administrator 'Microsoft.DBforMySQL/flexibleServers/administrators@2023-12-30' = {
  name: 'ActiveDirectory'
  parent: flexibleServer
  properties: {
    sid: deployer().objectId
    tenantId: tenant().tenantId
    administratorType: 'ActiveDirectory'
    identityResourceId: userAssignedIdentity.id
    login: 'sqladmin'
  }
}
