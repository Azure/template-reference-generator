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
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    siteConfig: {
      use32BitWorkerProcess: true
      acrUseManagedIdentityCreds: false
      http20Enabled: false
      localMySqlEnabled: false
      scmMinTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      ftpsState: 'Disabled'
      publicNetworkAccess: 'Enabled'
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      alwaysOn: true
      autoHealEnabled: false
      webSocketsEnabled: false
      windowsFxVersion: ''
      loadBalancing: 'LeastRequests'
      managedPipelineMode: 'Integrated'
      minTlsVersion: '1.2'
    }
    clientCertEnabled: false
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    clientAffinityEnabled: false
    clientCertExclusionPaths: ''
    publicNetworkAccess: 'Enabled'
    siteConfig: {
      autoHealEnabled: false
      ftpsState: 'Disabled'
      managedPipelineMode: 'Integrated'
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: false
      alwaysOn: true
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      publicNetworkAccess: 'Enabled'
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      webSocketsEnabled: false
      acrUseManagedIdentityCreds: false
      minTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      windowsFxVersion: ''
    }
    vnetRouteAllEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    serverFarmId: serverfarm.id
  }
}
