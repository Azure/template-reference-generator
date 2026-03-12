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
    clientCertMode: 'Required'
    httpsOnly: false
    serverFarmId: serverfarm.id
    siteConfig: {
      ftpsState: 'Disabled'
      minTlsVersion: '1.2'
      publicNetworkAccess: 'Enabled'
      webSocketsEnabled: false
      windowsFxVersion: ''
      acrUseManagedIdentityCreds: false
      http20Enabled: false
      managedPipelineMode: 'Integrated'
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: true
      alwaysOn: true
      autoHealEnabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      vnetRouteAllEnabled: false
    }
    vnetRouteAllEnabled: false
    enabled: true
    publicNetworkAccess: 'Enabled'
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
    clientCertExclusionPaths: ''
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    siteConfig: {
      acrUseManagedIdentityCreds: false
      autoHealEnabled: false
      loadBalancing: 'LeastRequests'
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
      http20Enabled: false
      vnetRouteAllEnabled: false
      localMySqlEnabled: false
      publicNetworkAccess: 'Enabled'
      remoteDebuggingEnabled: false
      scmIpSecurityRestrictionsUseMain: false
      scmMinTlsVersion: '1.2'
      use32BitWorkerProcess: false
      alwaysOn: true
      managedPipelineMode: 'Integrated'
      webSocketsEnabled: false
      windowsFxVersion: ''
    }
    clientCertEnabled: false
  }
}

resource config 'Microsoft.Web/sites/slots/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: slot
  properties: {}
}
