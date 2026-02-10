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
    vnetRouteAllEnabled: false
    httpsOnly: false
    siteConfig: {
      remoteDebuggingEnabled: false
      use32BitWorkerProcess: true
      windowsFxVersion: ''
      loadBalancing: 'LeastRequests'
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      localMySqlEnabled: false
      ftpsState: 'Disabled'
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      scmIpSecurityRestrictionsUseMain: false
      scmMinTlsVersion: '1.2'
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      autoHealEnabled: false
      http20Enabled: false
      publicNetworkAccess: 'Enabled'
    }
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    enabled: true
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
  }
}

resource config 'Microsoft.Web/sites/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: site
  properties: {}
}
