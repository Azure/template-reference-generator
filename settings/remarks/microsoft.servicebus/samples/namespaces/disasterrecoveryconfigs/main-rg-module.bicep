param resourceName string = 'acctest0001'
param location string = 'westus'
param secondaryLocation string = 'centralus'

resource namespace 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: '${resourceName}ns1'
  location: location
  sku: {
    name: 'Premium'
    tier: 'Premium'
    capacity: 1
  }
  properties: {
    disableLocalAuth: false
    minimumTlsVersion: '1.2'
    premiumMessagingPartitions: 1
    publicNetworkAccess: 'Enabled'
  }
}

resource disasterRecoveryConfig 'Microsoft.ServiceBus/namespaces/disasterRecoveryConfigs@2021-06-01-preview' = {
  name: '${resourceName}alias'
  parent: namespace
  properties: {
    partnerNamespace: namespace1.id
  }
}

resource namespace1 'Microsoft.ServiceBus/namespaces@2022-10-01-preview' = {
  name: '${resourceName}ns2'
  location: secondaryLocation
  sku: {
    name: 'Premium'
    tier: 'Premium'
    capacity: 1
  }
  properties: {
    disableLocalAuth: false
    minimumTlsVersion: '1.2'
    premiumMessagingPartitions: 1
    publicNetworkAccess: 'Enabled'
  }
}
