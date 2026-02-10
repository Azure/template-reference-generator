param resourceName string = 'acctest0001'
param location string = 'westeurope'

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
      alwaysOn: true
      managedPipelineMode: 'Integrated'
      scmMinTlsVersion: '1.2'
      acrUseManagedIdentityCreds: false
      autoHealEnabled: false
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      minTlsVersion: '1.2'
      publicNetworkAccess: 'Enabled'
      remoteDebuggingEnabled: false
      localMySqlEnabled: false
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      ftpsState: 'Disabled'
      windowsFxVersion: ''
    }
    vnetRouteAllEnabled: false
  }
}

resource serverfarm 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
  }
  properties: {
    perSiteScaling: false
    reserved: false
    zoneRedundant: false
    hyperV: false
  }
}
