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
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientCertMode: 'Required'
    httpsOnly: false
    siteConfig: {
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
      http20Enabled: false
      scmMinTlsVersion: '1.2'
      webSocketsEnabled: false
      acrUseManagedIdentityCreds: false
      alwaysOn: true
      ftpsState: 'Disabled'
      managedPipelineMode: 'Integrated'
      publicNetworkAccess: 'Enabled'
      windowsFxVersion: ''
      autoHealEnabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      minTlsVersion: '1.2'
    }
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    clientAffinityEnabled: false
    clientCertEnabled: false
    httpsOnly: false
    siteConfig: {
      remoteDebuggingEnabled: false
      webSocketsEnabled: false
      acrUseManagedIdentityCreds: false
      ftpsState: 'Disabled'
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      publicNetworkAccess: 'Enabled'
      scmIpSecurityRestrictionsUseMain: false
      autoHealEnabled: false
      managedPipelineMode: 'Integrated'
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: false
      alwaysOn: true
      http20Enabled: false
      minTlsVersion: '1.2'
      vnetRouteAllEnabled: false
      windowsFxVersion: ''
    }
    vnetRouteAllEnabled: false
    clientCertExclusionPaths: ''
    clientCertMode: 'Required'
    enabled: true
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
  }
}

resource config 'Microsoft.Web/sites/slots/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: slot
  properties: {}
}
