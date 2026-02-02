param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource accessConnector 'Microsoft.Databricks/accessConnectors@2022-10-01-preview' = {
  name: resourceName
  location: location
}
