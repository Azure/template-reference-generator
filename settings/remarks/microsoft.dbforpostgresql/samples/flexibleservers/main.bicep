param resourceName string = 'acctest0001'
param location string = 'eastus'
@description('The administrator login name for the PostgreSQL flexible server')
param administratorLogin string
@secure()
@description('The administrator login password for the PostgreSQL flexible server')
param administratorLoginPassword string

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2023-06-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_D2s_v3'
    tier: 'GeneralPurpose'
  }
  properties: {
    administratorLogin: '${administratorLogin}'
    administratorLoginPassword: '${administratorLoginPassword}'
    highAvailability: {
      mode: 'Disabled'
    }
    version: '12'
    availabilityZone: '2'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    network: {}
    storage: {
      storageSizeGB: 32
    }
  }
  identity: {
    type: 'None'
    userAssignedIdentities: null
  }
}
