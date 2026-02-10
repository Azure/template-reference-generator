param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the PostgreSQL server group')
param administratorLoginPassword string

resource serverGroupsv2 'Microsoft.DBforPostgreSQL/serverGroupsv2@2022-11-08' = {
  name: resourceName
  location: location
  properties: {
    administratorLoginPassword: '${administratorLoginPassword}'
    coordinatorEnablePublicIpAccess: true
    coordinatorVCores: 2
    enableHa: false
    nodeCount: 0
    nodeEnablePublicIpAccess: false
    coordinatorServerEdition: 'GeneralPurpose'
    coordinatorStorageQuotaInMb: 131072
    nodeServerEdition: 'MemoryOptimized'
  }
}
