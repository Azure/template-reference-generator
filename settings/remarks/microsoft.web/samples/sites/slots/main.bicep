param location string = 'westeurope'
param resourceName string = 'acctest0001'

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
    httpsOnly: false
    serverFarmId: serverfarm.id
    enabled: true
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      http20Enabled: false
      scmIpSecurityRestrictionsUseMain: false
      windowsFxVersion: ''
      ftpsState: 'Disabled'
      publicNetworkAccess: 'Enabled'
      webSocketsEnabled: false
      autoHealEnabled: false
      minTlsVersion: '1.2'
      remoteDebuggingEnabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
    }
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    clientCertMode: 'Required'
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      use32BitWorkerProcess: false
      acrUseManagedIdentityCreds: false
      minTlsVersion: '1.2'
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
      webSocketsEnabled: false
      alwaysOn: true
      autoHealEnabled: false
      http20Enabled: false
      publicNetworkAccess: 'Enabled'
      scmIpSecurityRestrictionsUseMain: false
      ftpsState: 'Disabled'
      managedPipelineMode: 'Integrated'
      vnetRouteAllEnabled: false
      windowsFxVersion: ''
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
    }
    vnetRouteAllEnabled: false
    clientCertExclusionPaths: ''
    enabled: true
    httpsOnly: false
    serverFarmId: serverfarm.id
    clientAffinityEnabled: false
    clientCertEnabled: false
  }
}
