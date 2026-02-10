param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource site 'Microsoft.Web/sites@2022-09-01' = {
  name: resourceName
  location: location
  properties: {
    clientCertEnabled: false
    clientCertMode: 'Required'
    enabled: true
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
    vnetRouteAllEnabled: false
    clientAffinityEnabled: false
    siteConfig: {
      acrUseManagedIdentityCreds: false
      publicNetworkAccess: 'Enabled'
      alwaysOn: true
      remoteDebuggingEnabled: false
      scmMinTlsVersion: '1.2'
      webSocketsEnabled: false
      loadBalancing: 'LeastRequests'
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      scmIpSecurityRestrictionsUseMain: false
      windowsFxVersion: ''
      autoHealEnabled: false
      ftpsState: 'Disabled'
      http20Enabled: false
      minTlsVersion: '1.2'
      use32BitWorkerProcess: true
      vnetRouteAllEnabled: false
    }
  }
}

resource slot 'Microsoft.Web/sites/slots@2022-09-01' = {
  name: resourceName
  location: location
  parent: site
  properties: {
    siteConfig: {
      publicNetworkAccess: 'Enabled'
      vnetRouteAllEnabled: false
      alwaysOn: true
      localMySqlEnabled: false
      managedPipelineMode: 'Integrated'
      remoteDebuggingEnabled: false
      ftpsState: 'Disabled'
      scmIpSecurityRestrictionsUseMain: false
      use32BitWorkerProcess: false
      webSocketsEnabled: false
      http20Enabled: false
      loadBalancing: 'LeastRequests'
      minTlsVersion: '1.2'
      scmMinTlsVersion: '1.2'
      windowsFxVersion: ''
      acrUseManagedIdentityCreds: false
      autoHealEnabled: false
    }
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    vnetRouteAllEnabled: false
    clientCertExclusionPaths: ''
    enabled: true
    httpsOnly: false
    publicNetworkAccess: 'Enabled'
    serverFarmId: serverfarm.id
  }
}

resource config 'Microsoft.Web/sites/slots/config@2022-09-01' = {
  name: 'azurestorageaccounts'
  parent: slot
  properties: {}
}

resource serverfarm 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'S1'
  }
  properties: {
    reserved: false
    zoneRedundant: false
    hyperV: false
    perSiteScaling: false
  }
}
