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
    clientCertEnabled: false
    enabled: true
    httpsOnly: false
    siteConfig: {
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      remoteDebuggingEnabled: false
      use32BitWorkerProcess: true
      ftpsState: 'Disabled'
      loadBalancing: 'LeastRequests'
      publicNetworkAccess: 'Enabled'
      scmIpSecurityRestrictionsUseMain: false
      windowsFxVersion: ''
      http20Enabled: false
      webSocketsEnabled: false
      alwaysOn: true
      autoHealEnabled: false
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      acrUseManagedIdentityCreds: false
    }
    vnetRouteAllEnabled: false
    clientCertMode: 'Required'
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    clientAffinityEnabled: false
    clientCertExclusionPaths: ''
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    vnetRouteAllEnabled: false
    clientCertEnabled: false
    serverFarmId: serverfarm.id
    siteConfig: {
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      use32BitWorkerProcess: false
      acrUseManagedIdentityCreds: false
      autoHealEnabled: false
      ftpsState: 'Disabled'
      publicNetworkAccess: 'Enabled'
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
      scmIpSecurityRestrictionsUseMain: false
      vnetRouteAllEnabled: false
      webSocketsEnabled: false
      windowsFxVersion: ''
      alwaysOn: true
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
    }
  }
}
