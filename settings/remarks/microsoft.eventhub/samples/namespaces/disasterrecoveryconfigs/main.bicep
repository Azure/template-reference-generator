param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource namespace 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: location
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
    isAutoInflateEnabled: false
  }
}

resource namespace2 'Microsoft.EventHub/namespaces@2022-01-01-preview' = {
  name: resourceName
  location: 'westus2'
  sku: {
    capacity: 1
    name: 'Standard'
    tier: 'Standard'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    zoneRedundant: false
    disableLocalAuth: false
    isAutoInflateEnabled: false
  }
}

resource disasterRecoveryConfig 'Microsoft.EventHub/namespaces/disasterRecoveryConfigs@2021-11-01' = {
  name: resourceName
  parent: namespace
  properties: {
    partnerNamespace: namespace2.id
  }
}
