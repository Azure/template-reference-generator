param location string = 'westeurope'
@description('The administrator login for the PostgreSQL flexible server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL flexible server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: resourceName
  location: location
  sku: {
    tier: 'GeneralPurpose'
    name: 'Standard_D2s_v3'
  }
  properties: {
    administratorLoginPassword: administratorLoginPassword
    authConfig: {
      tenantId: tenant().tenantId
      activeDirectoryAuth: 'Enabled'
      passwordAuth: 'Enabled'
    }
    availabilityZone: '2'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    network: {}
    storage: {
      storageSizeGB: 32
    }
    version: '12'
    administratorLogin: administratorLogin
  }
}

resource administrator 'Microsoft.DBforPostgreSQL/flexibleServers/administrators@2022-12-01' = {
  name: deployer().objectId
  parent: flexibleServer
  properties: {
    principalType: 'ServicePrincipal'
    tenantId: tenant().tenantId
  }
}
