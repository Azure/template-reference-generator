param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource serverfarm 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
  }
  properties: {
    hyperV: false
    perSiteScaling: false
    reserved: false
    zoneRedundant: false
  }
}

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
    clientCertMode: 'Required'
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      scmIpSecurityRestrictionsUseMain: false
      use32BitWorkerProcess: true
      webSocketsEnabled: false
      alwaysOn: true
      minTlsVersion: '1.2'
      acrUseManagedIdentityCreds: false
      localMySqlEnabled: false
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      windowsFxVersion: ''
      autoHealEnabled: false
      ftpsState: 'Disabled'
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      managedPipelineMode: 'Integrated'
      publicNetworkAccess: 'Enabled'
    }
    clientCertEnabled: false
    enabled: true
    httpsOnly: false
  }
}

resource config 'Microsoft.Web/sites/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: site
  properties: {}
}
