param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      relativeName: 'acctest-tmp-230630034107605443'
      ttl: 30
    }
    monitorConfig: {
      intervalInSeconds: 30
      path: '/'
      port: 443
      protocol: 'HTTPS'
      timeoutInSeconds: 10
      toleratedNumberOfFailures: 3
      expectedStatusCodeRanges: []
    }
    trafficRoutingMethod: 'Weighted'
  }
}

resource trafficManagerProfile2 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      ttl: 30
      relativeName: 'acctesttmpchild230630034107605443'
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
    trafficRoutingMethod: 'Priority'
  }
}

resource nestedEndpoint 'Microsoft.Network/trafficManagerProfiles/NestedEndpoints@2018-08-01' = {
  name: resourceName
  parent: trafficManagerProfile
  properties: {
    weight: 3
    customHeaders: []
    endpointStatus: 'Enabled'
    minChildEndpoints: 5
    subnets: []
    targetResourceId: trafficManagerProfile2.id
  }
}
