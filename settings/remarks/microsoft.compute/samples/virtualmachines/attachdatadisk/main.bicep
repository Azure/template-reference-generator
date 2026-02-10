param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the virtual machine')
param adminUsername string
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

var dataDiskName = 'mydatadisk1'
var attachedDataDiskName = 'myattacheddatadisk1'
var osDiskName = 'myosdisk1'

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_F2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            primary: false
          }
        }
      ]
    }
    osProfile: {
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: 'hostname230630032848831819'
    }
    storageProfile: {
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        name: osDiskName
        writeAcceleratorEnabled: false
      }
      dataDisks: [
        {
          lun: 1
          managedDisk: {
            storageAccountType: 'Standard_LRS'
          }
          caching: 'ReadWrite'
          createOption: 'Empty'
          name: dataDiskName
          diskSizeGB: 1
        }
        {
          caching: 'ReadWrite'
          createOption: 'Attach'
          name: attachedDisk.name
          lun: 2
          managedDisk: {
            id: attachedDisk.id
          }
        }
      ]
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
  }
}

resource attachedDisk 'Microsoft.Compute/disks@2022-03-02' = {
  name: attachedDataDiskName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    osType: 'Linux'
    publicNetworkAccess: 'Enabled'
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: 1
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
          primary: true
        }
      }
    ]
  }
}
