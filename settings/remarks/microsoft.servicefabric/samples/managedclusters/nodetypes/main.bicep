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
    dnsName: '${resourceName}'
    httpGatewayConnectionPort: 23456
    networkSecurityRules: [
      {
        protocol: 'tcp'
        sourcePortRanges: [
          '1-65535'
        ]
        access: 'allow'
        destinationAddressPrefixes: [
          '0.0.0.0/0'
        ]
        destinationPortRanges: [
          '443'
        ]
        direction: 'inbound'
        sourceAddressPrefixes: [
          '0.0.0.0/0'
        ]
        name: 'rule443-allow-fe'
        priority: 1000
      }
    ]
    addonFeatures: [
      'DnsService'
    ]
    adminPassword: '${adminPassword}'
    clientConnectionPort: 12345
    clusterUpgradeCadence: 'Wave0'
    loadBalancingRules: [
      {
        probeProtocol: 'http'
        probeRequestPath: '/'
        protocol: 'tcp'
        backendPort: 8000
        frontendPort: 443
      }
    ]
    adminUserName: '${adminUsername}'
  }
  tags: {
    Test: 'value'
  }
}

resource nodeType 'Microsoft.ServiceFabric/managedClusters/nodeTypes@2021-05-01' = {
  name: resourceName
  parent: managedCluster
  properties: {
    isPrimary: true
    vmImageVersion: 'latest'
    capacities: {}
    isStateless: false
    vmImageOffer: 'WindowsServer'
    vmImagePublisher: 'MicrosoftWindowsServer'
    vmSecrets: []
    applicationPorts: {
      endPort: 9000
      startPort: 7000
    }
    dataDiskSizeGB: 130
    multiplePlacementGroups: false
    vmSize: 'Standard_DS2_v2'
    vmInstanceCount: 5
    dataDiskType: 'Standard_LRS'
    ephemeralPorts: {
      endPort: 20000
      startPort: 10000
    }
    placementProperties: {}
    vmImageSku: '2016-Datacenter'
  }
}
