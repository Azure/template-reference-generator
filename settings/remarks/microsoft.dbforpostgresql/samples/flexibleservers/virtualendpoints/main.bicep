param location string = 'westus'
@secure()
@description('The administrator login password for the PostgreSQL flexible server')
param administratorLoginPassword string
param resourceName string = 'acctest0001'

resource flexibleServer 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-primary'
  location: location
  sku: {
    name: 'Standard_D2ads_v5'
    tier: 'GeneralPurpose'
  }
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Disabled'
    }
    administratorLogin: 'psqladmin'
    availabilityZone: '1'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    storage: {
      autoGrow: 'Disabled'
      storageSizeGB: 32
      tier: 'P30'
    }
    version: '16'
  }
}

resource flexibleserver1 'Microsoft.DBforPostgreSQL/flexibleServers@2024-08-01' = {
  name: '${resourceName}-replica'
  location: location
  properties: {
    availabilityZone: '1'
    createMode: 'Replica'
    highAvailability: {
      mode: 'Disabled'
    }
    network: {
      publicNetworkAccess: 'Disabled'
    }
    storage: {
      storageSizeGB: 32
      tier: 'P30'
      autoGrow: 'Disabled'
    }
    version: '16'
    backup: {
      geoRedundantBackup: 'Disabled'
    }
    sourceServerResourceId: flexibleServer.id
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
