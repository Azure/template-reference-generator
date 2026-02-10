param location string = 'westeurope'
param resourceName string = 'acctest0001'

resource cluster 'Microsoft.ServiceFabric/clusters@2021-06-01' = {
  name: resourceName
  location: location
  properties: {
    addOnFeatures: []
    fabricSettings: []
    managementEndpoint: 'http://example:80'
    nodeTypes: [
      {
        isStateless: false
        name: 'first'
        placementProperties: {}
        vmInstanceCount: 3
        clientConnectionEndpointPort: 2020
        httpGatewayEndpointPort: 80
        multipleAvailabilityZones: false
        capacities: {}
        durabilityLevel: 'Bronze'
        isPrimary: true
      }
    ]
    reliabilityLevel: 'Bronze'
    upgradeMode: 'Automatic'
    vmImage: 'Windows'
  }
}
