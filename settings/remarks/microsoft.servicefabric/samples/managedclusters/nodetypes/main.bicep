@description('The administrator username for the Service Fabric managed cluster')
param adminUsername string
@secure()
@description('The administrator password for the Service Fabric managed cluster')
param adminPassword string
param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource managedCluster 'Microsoft.ServiceFabric/managedClusters@2021-05-01' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    clientConnectionPort: 12345
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
    networkSecurityRules: [
      {
        destinationAddressPrefixes: [
          '0.0.0.0/0'
        ]
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
        access: 'allow'
        sourceAddressPrefixes: [
          '0.0.0.0/0'
        ]
      }
    ]
    addonFeatures: [
      'DnsService'
    ]
    adminPassword: '${adminPassword}'
    adminUserName: '${adminUsername}'
    clusterUpgradeCadence: 'Wave0'
    dnsName: '${resourceName}'
  }
  tags: {
    Test: 'value'
  }
}

resource nodeType 'Microsoft.ServiceFabric/managedClusters/nodeTypes@2021-05-01' = {
  name: resourceName
  parent: managedCluster
  properties: {
    capacities: {}
    dataDiskType: 'Standard_LRS'
    multiplePlacementGroups: false
    vmImageOffer: 'WindowsServer'
    vmImagePublisher: 'MicrosoftWindowsServer'
    ephemeralPorts: {
      endPort: 20000
      startPort: 10000
    }
    vmInstanceCount: 5
    vmSecrets: []
    vmSize: 'Standard_DS2_v2'
    vmImageSku: '2016-Datacenter'
    dataDiskSizeGB: 130
    isPrimary: true
    isStateless: false
    applicationPorts: {
      endPort: 9000
      startPort: 7000
    }
    placementProperties: {}
    vmImageVersion: 'latest'
  }
}
