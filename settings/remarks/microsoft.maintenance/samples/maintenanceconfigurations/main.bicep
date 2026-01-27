param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource maintenanceConfiguration 'Microsoft.Maintenance/maintenanceConfigurations@2022-07-01-preview' = {
  name: resourceName
  location: location
  properties: {
    extensionProperties: {}
    maintenanceScope: 'SQLDB'
    namespace: 'Microsoft.Maintenance'
    visibility: 'Custom'
  }
}
