param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the Service Fabric managed cluster')
param adminUsername string
@secure()
@description('The administrator password for the Service Fabric managed cluster')
param adminPassword string

resource managedCluster 'Microsoft.ServiceFabric/managedClusters@2021-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserName: '${adminUsername}'
    httpGatewayConnectionPort: 23456
    loadBalancingRules: [
      {
        probeProtocol: 'http'
        probeRequestPath: '/'
        protocol: 'tcp'
        backendPort: 8000
        frontendPort: 443
      }
    ]
    networkSecurityRules: [
      {
        access: 'allow'
        destinationPortRanges: [
          '443'
        ]
        direction: 'inbound'
        name: 'rule443-allow-fe'
        priority: 1000
        protocol: 'tcp'
        sourcePortRanges: [
          '1-65535'
        ]
        destinationAddressPrefixes: [
          '0.0.0.0/0'
        ]
        sourceAddressPrefixes: [
          '0.0.0.0/0'
        ]
      }
    ]
    addonFeatures: [
      'DnsService'
    ]
    adminPassword: '${adminPassword}'
    clientConnectionPort: 12345
    clusterUpgradeCadence: 'Wave0'
    dnsName: '${resourceName}'
  }
  tags: {
    Test: 'value'
  }
}
