param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
}

resource schemaGroup 'Microsoft.EventHub/namespaces/schemaGroups@2021-11-01' = {
  name: resourceName
  parent: namespace
  properties: {
    schemaCompatibility: 'Forward'
    schemaType: 'Avro'
  }
}
