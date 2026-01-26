param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource cluster 'Microsoft.ServiceFabric/clusters@2021-06-01' = {
  name: resourceName
  location: location
  properties: {
    addOnFeatures: []
    fabricSettings: []
    managementEndpoint: 'http://example:80'
    nodeTypes: [
      {
        capacities: {}
        clientConnectionEndpointPort: 2020
        durabilityLevel: 'Bronze'
        httpGatewayEndpointPort: 80
        isPrimary: true
        isStateless: false
        multipleAvailabilityZones: false
        name: 'first'
        placementProperties: {}
        vmInstanceCount: 3
      }
    ]
    reliabilityLevel: 'Bronze'
    upgradeMode: 'Automatic'
    vmImage: 'Windows'
  }
}
