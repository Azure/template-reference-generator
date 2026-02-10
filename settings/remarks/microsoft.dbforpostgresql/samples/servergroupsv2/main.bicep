param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator login password for the PostgreSQL server group')
param administratorLoginPassword string

resource serverGroupsv2 'Microsoft.DBforPostgreSQL/serverGroupsv2@2022-11-08' = {
  name: resourceName
  location: location
  properties: {
    coordinatorEnablePublicIpAccess: true
    enableHa: false
    nodeCount: 0
    nodeEnablePublicIpAccess: false
    administratorLoginPassword: '${administratorLoginPassword}'
    coordinatorServerEdition: 'GeneralPurpose'
    coordinatorStorageQuotaInMb: 131072
    coordinatorVCores: 2
    nodeServerEdition: 'MemoryOptimized'
  }
}
