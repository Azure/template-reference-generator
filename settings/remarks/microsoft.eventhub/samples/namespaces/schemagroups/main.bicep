param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  properties: {
    disableLocalAuth: false
    isAutoInflateEnabled: false
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
  }
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
}

resource schemaGroup 'Microsoft.EventHub/namespaces/schemaGroups@2021-11-01' = {
  parent: namespace
  name: resourceName
  properties: {
    schemaCompatibility: 'Forward'
    schemaType: 'Avro'
  }
}
