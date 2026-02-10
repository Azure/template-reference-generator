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
  name: resourceName
  location: location
  parent: lab
  properties: {
    labSubnetName: '${resourceName}Subnet'
    osType: 'Windows'
    size: 'Standard_F2'
    userName: 'acct5stU5er'
    galleryImageReference: {
      osType: 'Windows'
      publisher: 'MicrosoftWindowsServer'
      sku: '2012-Datacenter'
      version: 'latest'
      offer: 'WindowsServer'
    }
    networkInterface: {}
    notes: ''
    password: vmPassword
    storageType: 'Standard'
    allowClaim: true
    disallowPublicIpAddress: false
    isAuthenticationWithSshKey: false
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
