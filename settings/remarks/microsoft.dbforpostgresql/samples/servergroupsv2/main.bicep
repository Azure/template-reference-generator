@secure()
@description('The administrator login password for the PostgreSQL server group')
param administratorLoginPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource serverGroupsv2 'Microsoft.DBforPostgreSQL/serverGroupsv2@2022-11-08' = {
  name: resourceName
  location: location
  properties: {
    coordinatorEnablePublicIpAccess: true
    coordinatorServerEdition: 'GeneralPurpose'
    coordinatorStorageQuotaInMb: 131072
    coordinatorVCores: 2
    enableHa: false
    nodeCount: 0
    nodeEnablePublicIpAccess: false
    nodeServerEdition: 'MemoryOptimized'
    administratorLoginPassword: '${administratorLoginPassword}'
  }
}
