param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource trafficManagerProfile 'Microsoft.Network/trafficManagerProfiles@2018-08-01' = {
  name: resourceName
  location: 'global'
  properties: {
    dnsConfig: {
      ttl: 30
      relativeName: 'acctest-tmp-230630034107605443'
    }
    monitorConfig: {
      path: '/'
      port: 443
      protocol: 'HTTPS'
      timeoutInSeconds: 10
      toleratedNumberOfFailures: 3
      expectedStatusCodeRanges: []
      intervalInSeconds: 30
    }
    trafficRoutingMethod: 'Weighted'
  }
}
