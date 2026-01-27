param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The password for the DevTest Lab virtual machine')
param vmPassword string

resource lab 'Microsoft.DevTestLab/labs@2018-09-15' = {
  name: resourceName
  location: location
  properties: {
    labStorageType: 'Premium'
  }
}

resource virtualMachine 'Microsoft.DevTestLab/labs/virtualMachines@2018-09-15' = {
  parent: lab
  name: resourceName
  location: location
  properties: {
    allowClaim: true
    disallowPublicIpAddress: false
    galleryImageReference: {
      offer: 'WindowsServer'
      osType: 'Windows'
      publisher: 'MicrosoftWindowsServer'
      sku: '2012-Datacenter'
      version: 'latest'
    }
    isAuthenticationWithSshKey: false
    labSubnetName: '\'${resourceName}Subnet\''
    labVirtualNetworkId: virtualNetwork.id
    networkInterface: {}
    notes: ''
    osType: 'Windows'
    password: null
    size: 'Standard_F2'
    storageType: 'Standard'
    userName: 'acct5stU5er'
  }
}

resource virtualNetwork 'Microsoft.DevTestLab/labs/virtualNetworks@2018-09-15' = {
  parent: lab
  name: resourceName
  properties: {
    description: ''
    subnetOverrides: [
      {
        labSubnetName: '\'${resourceName}Subnet\''
        resourceId: resourceId('Microsoft.Network/virtualNetworks/subnets', resourceName, '${resourceName}Subnet')
        useInVmCreationPermission: 'Allow'
        usePublicIpAddressPermission: 'Allow'
      }
    ]
  }
}
