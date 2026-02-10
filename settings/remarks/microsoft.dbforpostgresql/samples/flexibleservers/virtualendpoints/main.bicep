param location string = 'westus'
@secure()
@description('The administrator login password for the PostgreSQL flexible server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource flexibleserver1 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-replica'
  location: location
  properties: {
    network: {
      publicNetworkAccess: 'Disabled'
    }
    storage: {
      autoGrow: 'Disabled'
      storageSizeGB: 32
      tier: 'P30'
    }
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    sourceServerResourceId: flexibleServer.id
    version: '16'
    availabilityZone: '1'
    createMode: 'Replica'
    highAvailability: {
      mode: 'Disabled'
    }
  }
}

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-primary'
  location: location
  sku: {
    name: 'Standard_D2ads_v5'
    tier: 'GeneralPurpose'
  }
  properties: {
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    storage: {
      autoGrow: 'Disabled'
      storageSizeGB: 32
      tier: 'P30'
    }
    administratorLogin: 'psqladmin'
    administratorLoginPassword: '${administratorLoginPassword}'
    availabilityZone: '1'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Disabled'
    }
    version: '16'
  }
}

resource virtualEndpoint 'Microsoft.DBforPostgreSQL/flexibleServers/virtualEndpoints@2024-08-01' = {
  name: resourceName
  parent: flexibleServer
  properties: {
    endpointType: 'ReadWrite'
    members: [
      flexibleserver1.name
    ]
  }
}
