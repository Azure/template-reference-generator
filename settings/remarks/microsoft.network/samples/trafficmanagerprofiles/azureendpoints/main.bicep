param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2022-07-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Basic'
    tier: 'Regional'
  }
  properties: {
    ddosSettings: {
      protectionMode: 'VirtualNetworkInherited'
    }
    dnsSettings: {
      domainNameLabel: 'acctestpublicip-230630034107607730'
    }
    idleTimeoutInMinutes: 4
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      relativeName: 'acctest-tmp-230630034107607730'
      ttl: 30
    }
    monitorConfig: {
      expectedStatusCodeRanges: []
      intervalInSeconds: 30
      path: '/'
      port: 443
      protocol: 'HTTPS'
      timeoutInSeconds: 10
      toleratedNumberOfFailures: 3
    }
    trafficRoutingMethod: 'Weighted'
  }
}

resource azureEndpoint 'Microsoft.Network/trafficManagerProfiles/AzureEndpoints@2018-08-01' = {
  name: resourceName
  parent: trafficManagerProfile
  properties: {
    customHeaders: []
    endpointStatus: 'Enabled'
    subnets: []
    targetResourceId: publicIPAddress.id
    weight: 3
  }
}
