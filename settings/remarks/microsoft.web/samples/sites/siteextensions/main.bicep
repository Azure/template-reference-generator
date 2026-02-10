param resourceName string = 'acctest0001'
param resourceSiteName string = 'acctestsite0001'
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
  name: resourceSiteName
  location: location
  properties: {
    clientCertMode: 'Required'
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      acrUseManagedIdentityCreds: false
      http20Enabled: false
      localMySqlEnabled: false
      remoteDebuggingEnabled: false
      use32BitWorkerProcess: true
      alwaysOn: true
      ftpsState: 'Disabled'
      scmIpSecurityRestrictionsUseMain: false
      vnetRouteAllEnabled: false
      windowsFxVersion: ''
      autoHealEnabled: false
      loadBalancing: 'LeastRequests'
      publicNetworkAccess: 'Enabled'
      webSocketsEnabled: false
    }
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    enabled: true
    serverFarmId: serverfarm.id
  }
}

resource dynatraceSiteExtension 'Microsoft.Web/sites/siteextensions@2022-09-01' = {
  name: 'Dynatrace'
  location: location
  parent: site
}
