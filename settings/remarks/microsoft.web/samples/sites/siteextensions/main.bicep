param location string = 'westeurope'
param resourceName string = 'acctest0001'
param resourceSiteName string = 'acctestsite0001'

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceSiteName
  location: location
  properties: {
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    clientAffinityEnabled: false
    clientCertEnabled: false
    siteConfig: {
      acrUseManagedIdentityCreds: false
      autoHealEnabled: false
      ftpsState: 'Disabled'
      http20Enabled: false
      use32BitWorkerProcess: true
      loadBalancing: 'LeastRequests'
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      webSocketsEnabled: false
      windowsFxVersion: ''
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      scmMinTlsVersion: '1.2'
      alwaysOn: true
      localMySqlEnabled: false
      publicNetworkAccess: 'Enabled'
      vnetRouteAllEnabled: false
    }
    vnetRouteAllEnabled: false
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
  }
}

resource dynatraceSiteExtension 'Microsoft.Web/sites/siteextensions@2022-09-01' = {
  name: 'Dynatrace'
  location: location
  parent: site
}

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
