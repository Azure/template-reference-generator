param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.ServiceFabric/clusters@2021-06-01' = {
  name: resourceName
  location: location
  properties: {
    upgradeMode: 'Automatic'
    vmImage: 'Windows'
    addOnFeatures: []
    fabricSettings: []
    managementEndpoint: 'http://example:80'
    nodeTypes: [
      {
        capacities: {}
        durabilityLevel: 'Bronze'
        httpGatewayEndpointPort: 80
        isPrimary: true
        isStateless: false
        name: 'first'
        vmInstanceCount: 3
        clientConnectionEndpointPort: 2020
        multipleAvailabilityZones: false
        placementProperties: {}
      }
    ]
    reliabilityLevel: 'Bronze'
  }
}
