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
    clientCertEnabled: false
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
    serverFarmId: serverfarm.id
    siteConfig: {
      windowsFxVersion: ''
      scmMinTlsVersion: '1.2'
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      ftpsState: 'Disabled'
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      minTlsVersion: '1.2'
      managedPipelineMode: 'Integrated'
      remoteDebuggingEnabled: false
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      autoHealEnabled: false
      publicNetworkAccess: 'Enabled'
    }
  }
}
