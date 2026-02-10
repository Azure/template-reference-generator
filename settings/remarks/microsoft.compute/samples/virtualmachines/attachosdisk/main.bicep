param attachedResourceName string = 'acctest0002'
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the virtual machine')
param adminUsername string
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

var osDiskName = 'myosdisk1'
var attachedOsDiskName = 'myosdisk2'

resource managedDisk 'Microsoft.Compute/disks@2023-10-02' existing = {
  name: osDiskName
}

resource snapshot 'Microsoft.Compute/snapshots@2023-10-02' = {
  name: resourceName
  location: location
  sku: {
    name: 'Standard_ZRS'
  }
  properties: {
    creationData: {
      createOption: 'Copy'
      sourceResourceId: managedDisk.id
    }
    diskSizeGB: 30
    networkAccessPolicy: 'AllowAll'
    hyperVGeneration: 'V1'
    incremental: true
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    osType: 'Linux'
    publicNetworkAccess: 'Enabled'
    supportedCapabilities: {
      architecture: 'x64'
    }
  }
}

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
          properties: {
            primary: false
          }
          id: networkInterface.id
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: 'hostname230630032848831819'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        sku: '16.04-LTS'
        version: 'latest'
        offer: 'UbuntuServer'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        name: osDiskName
        writeAcceleratorEnabled: false
      }
    }
  }
}

resource attachedManagedDisk 'Microsoft.Compute/disks@2023-10-02' = {
  name: attachedOsDiskName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    networkAccessPolicy: 'AllowAll'
    hyperVGeneration: 'V1'
    publicNetworkAccess: 'Enabled'
    supportedCapabilities: {
      architecture: 'x64'
    }
    creationData: {
      createOption: 'Copy'
    }
    osType: 'Linux'
    diskSizeGB: 30
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
  }
}

resource attachedNetworkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: attachedResourceName
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'testconfiguration2'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
  }
}

resource attachedVirtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: attachedResourceName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_F2'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: attachedNetworkInterface.id
          properties: {
            primary: false
          }
        }
      ]
    }
    storageProfile: {
      osDisk: {
        name: attachedOsDiskName
        osType: 'Linux'
        writeAcceleratorEnabled: false
        managedDisk: {
          id: attachedManagedDisk.id
        }
        caching: 'ReadWrite'
        createOption: 'Attach'
      }
    }
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'testconfiguration1'
        properties: {
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
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
