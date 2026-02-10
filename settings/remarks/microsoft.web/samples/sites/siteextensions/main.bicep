param resourceName string = 'acctest0001'
param resourceSiteName string = 'acctestsite0001'
param location string = 'westeurope'

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceSiteName
  location: location
  properties: {
    clientAffinityEnabled: false
    enabled: true
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    httpsOnly: false
    siteConfig: {
      acrUseManagedIdentityCreds: false
      ftpsState: 'Disabled'
      http20Enabled: false
      localMySqlEnabled: false
      minTlsVersion: '1.2'
      webSocketsEnabled: false
      windowsFxVersion: ''
      alwaysOn: true
      remoteDebuggingEnabled: false
      use32BitWorkerProcess: true
      loadBalancing: 'LeastRequests'
      scmIpSecurityRestrictionsUseMain: false
      scmMinTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      autoHealEnabled: false
      managedPipelineMode: 'Integrated'
      publicNetworkAccess: 'Enabled'
    }
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
