param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource serverfarm 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
  }
  properties: {
    zoneRedundant: false
    hyperV: false
    perSiteScaling: false
    reserved: false
  }
}

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    clientAffinityEnabled: false
    clientCertMode: 'Required'
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      alwaysOn: true
      autoHealEnabled: false
      http20Enabled: false
      remoteDebuggingEnabled: false
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      scmIpSecurityRestrictionsUseMain: false
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      publicNetworkAccess: 'Enabled'
      acrUseManagedIdentityCreds: false
      ftpsState: 'Disabled'
      loadBalancing: 'LeastRequests'
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: true
      windowsFxVersion: ''
    }
    clientCertEnabled: false
    enabled: true
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
  }
}

resource config 'Microsoft.Web/sites/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: site
  properties: {}
}
