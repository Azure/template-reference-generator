param resourceName string = 'acctest0001'

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      relativeName: 'acctest-tmp-230630034107608613'
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

resource externalendpoint 'Microsoft.Network/trafficManagerProfiles/ExternalEndpoints@2018-08-01' = {
  parent: trafficManagerProfile
  name: resourceName
  properties: {
    customHeaders: []
    endpointStatus: 'Enabled'
    subnets: []
    target: 'www.example.com'
    weight: 3
  }
}
