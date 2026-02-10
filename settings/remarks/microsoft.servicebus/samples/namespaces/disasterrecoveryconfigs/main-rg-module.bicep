param location string = 'westus'
param secondaryLocation string = 'centralus'
param resourceName string = 'acctest0001'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: '${resourceName}ns1'
  location: location
  sku: {
    capacity: 1
    name: 'Premium'
    tier: 'Premium'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    minimumTlsVersion: '1.2'
    premiumMessagingPartitions: 1
  }
}

resource namespace1 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: '${resourceName}ns2'
  location: secondaryLocation
  sku: {
    capacity: 1
    name: 'Premium'
    tier: 'Premium'
  }
  properties: {
    premiumMessagingPartitions: 1
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    minimumTlsVersion: '1.2'
  }
}

resource disasterRecoveryConfig 'Microsoft.ServiceBus/namespaces/disasterRecoveryConfigs@2021-06-01-preview' = {
  name: '${resourceName}alias'
  parent: namespace
  properties: {
    partnerNamespace: namespace1.id
  }
}
