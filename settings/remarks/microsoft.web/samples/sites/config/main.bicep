param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource serverfarm 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    hyperV: false
    perSiteScaling: false
    reserved: false
    zoneRedundant: false
  }
  sku: {
    name: 'S1'
  }
}

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      autoHealEnabled: false
      ftpsState: 'Disabled'
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      publicNetworkAccess: 'Enabled'
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      windowsFxVersion: ''
    }
    vnetRouteAllEnabled: false
  }
}

resource config 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: site
  name: 'azurestorageaccounts'
  properties: {}
}
