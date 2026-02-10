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
    adminPassword: '${adminPassword}'
    adminUserName: '${adminUsername}'
    clientConnectionPort: 12345
    clusterUpgradeCadence: 'Wave0'
    dnsName: '${resourceName}'
    loadBalancingRules: [
      {
        protocol: 'tcp'
        backendPort: 8000
        frontendPort: 443
        probeProtocol: 'http'
        probeRequestPath: '/'
      }
    ]
    networkSecurityRules: [
      {
        direction: 'inbound'
        priority: 1000
        protocol: 'tcp'
        sourcePortRanges: [
          '1-65535'
        ]
        access: 'allow'
        name: 'rule443-allow-fe'
        sourceAddressPrefixes: [
          '0.0.0.0/0'
        ]
        destinationAddressPrefixes: [
          '0.0.0.0/0'
        ]
        destinationPortRanges: [
          '443'
        ]
      }
    ]
    addonFeatures: [
      'DnsService'
    ]
    httpGatewayConnectionPort: 23456
  }
  tags: {
    Test: 'value'
  }
}

resource nodeType 'Microsoft.ServiceFabric/managedClusters/nodeTypes@2021-05-01' = {
  name: resourceName
  parent: managedCluster
  properties: {
    vmInstanceCount: 5
    dataDiskSizeGB: 130
    multiplePlacementGroups: false
    vmImageOffer: 'WindowsServer'
    vmImageSku: '2016-Datacenter'
    dataDiskType: 'Standard_LRS'
    ephemeralPorts: {
      endPort: 20000
      startPort: 10000
    }
    isStateless: false
    vmImagePublisher: 'MicrosoftWindowsServer'
    vmSize: 'Standard_DS2_v2'
    vmImageVersion: 'latest'
    applicationPorts: {
      endPort: 9000
      startPort: 7000
    }
    capacities: {}
    isPrimary: true
    placementProperties: {}
    vmSecrets: []
  }
}
