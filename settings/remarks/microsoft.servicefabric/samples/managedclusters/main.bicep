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
    networkSecurityRules: [
      {
        access: 'allow'
        destinationAddressPrefixes: [
          '0.0.0.0/0'
        ]
        destinationPortRanges: [
          '443'
        ]
        name: 'rule443-allow-fe'
        priority: 1000
        protocol: 'tcp'
        direction: 'inbound'
        sourceAddressPrefixes: [
          '0.0.0.0/0'
        ]
        sourcePortRanges: [
          '1-65535'
        ]
      }
    ]
    addonFeatures: [
      'DnsService'
    ]
    adminUserName: '${adminUsername}'
    clientConnectionPort: 12345
    clusterUpgradeCadence: 'Wave0'
    dnsName: '${resourceName}'
    httpGatewayConnectionPort: 23456
    loadBalancingRules: [
      {
        backendPort: 8000
        frontendPort: 443
        probeProtocol: 'http'
        probeRequestPath: '/'
        protocol: 'tcp'
      }
    ]
    adminPassword: '${adminPassword}'
  }
  tags: {
    Test: 'value'
  }
}
