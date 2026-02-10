param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource iotApp 'Microsoft.IoTCentral/iotApps@2021-11-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'ST1'
  }
  properties: {
    subdomain: 'subdomain-2306300333537'
    template: 'iotc-pnp-preview@1.0.0'
    displayName: '${resourceName}'
    publicNetworkAccess: 'Enabled'
  }
}
