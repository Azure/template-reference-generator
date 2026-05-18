param resourceName string = 'acctest0001'
param location string = 'westeurope'

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
  properties: {
    labStorageType: 'Premium'
  }
}

resource virtualNetwork 'Microsoft.DevTestLab/labs/virtualNetworks@2018-09-15' = {
  name: resourceName
  parent: lab
  properties: {
    description: ''
    subnetOverrides: [
      {
        labSubnetName: '${resourceName}Subnet'
        resourceId: resourceId(
          'Microsoft.Network/virtualNetworks/subnets',
          resourceGroup().name,
          resourceName,
          '${resourceName}Subnet'
        )
        useInVmCreationPermission: 'Allow'
        usePublicIpAddressPermission: 'Allow'
      }
    ]
  }
}
