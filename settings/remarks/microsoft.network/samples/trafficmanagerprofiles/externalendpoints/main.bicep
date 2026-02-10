param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      relativeName: 'acctest-tmp-230630034107608613'
      ttl: 30
    }
    monitorConfig: {
      port: 443
      protocol: 'HTTPS'
      timeoutInSeconds: 10
      toleratedNumberOfFailures: 3
      expectedStatusCodeRanges: []
      intervalInSeconds: 30
      path: '/'
    }
    trafficRoutingMethod: 'Weighted'
  }
}

resource externalEndpoint 'Microsoft.Network/trafficManagerProfiles/ExternalEndpoints@2018-08-01' = {
  name: resourceName
  parent: trafficManagerProfile
  properties: {
    customHeaders: []
    endpointStatus: 'Enabled'
    subnets: []
    target: 'www.example.com'
    weight: 3
  }
}
