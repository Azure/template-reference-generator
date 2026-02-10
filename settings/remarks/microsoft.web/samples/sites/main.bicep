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
    clientAffinityEnabled: false
    enabled: true
    httpsOnly: false
    vnetRouteAllEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      use32BitWorkerProcess: true
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
      autoHealEnabled: false
      ftpsState: 'Disabled'
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      publicNetworkAccess: 'Enabled'
      webSocketsEnabled: false
      windowsFxVersion: ''
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      scmIpSecurityRestrictionsUseMain: false
      vnetRouteAllEnabled: false
    }
  }
}
