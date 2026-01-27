param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator login password for the PostgreSQL flexible server')
param administratorLoginPassword string

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-primary'
  location: location
  properties: {
    administratorLogin: 'psqladmin'
    administratorLoginPassword: null
    availabilityZone: '1'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Disabled'
    }
    storage: {
      autoGrow: 'Disabled'
      storageSizeGB: 32
      tier: 'P30'
    }
    version: '16'
  }
  sku: {
    name: 'Standard_D2ads_v5'
    tier: 'GeneralPurpose'
  }
}

resource flexibleserver1 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-replica'
  location: location
  properties: {
    availabilityZone: '1'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    createMode: 'Replica'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Disabled'
    }
    sourceServerResourceId: flexibleServer.id
    storage: {
      autoGrow: 'Disabled'
      storageSizeGB: 32
      tier: 'P30'
    }
    version: '16'
  }
}

resource virtualEndpoint 'Microsoft.DBforPostgreSQL/flexibleServers/virtualEndpoints@2024-08-01' = {
  parent: flexibleServer
  name: resourceName
  properties: {
    endpointType: 'ReadWrite'
    members: [
      flexibleserver1.name
    ]
  }
}
