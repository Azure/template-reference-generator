@secure()
@description('The administrator password for the virtual machine')
param adminPassword string
param attachedResourceName string = 'acctest0002'
param resourceName string = 'acctest0001'
param location string = 'westeurope'
@description('The administrator username for the virtual machine')
param adminUsername string

var attachedOsDiskName = 'myosdisk2'
var osDiskName = 'myosdisk1'

resource managedDisk 'Microsoft.Compute/disks@2023-10-02' existing = {
  name: osDiskName
}

resource attachedNetworkInterface 'Microsoft.Network/networkInterfaces@2022-07-01' = {
  name: attachedResourceName
  location: location
  properties: {
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
    enableAcceleratedNetworking: false
  }
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
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    osType: 'Linux'
    hyperVGeneration: 'V1'
    incremental: true
    supportedCapabilities: {
      architecture: 'x64'
    }
    networkAccessPolicy: 'AllowAll'
    publicNetworkAccess: 'Enabled'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
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
      computerName: 'hostname230630032848831819'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
      adminPassword: adminPassword
      adminUsername: adminUsername
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
    }
    hardwareProfile: {
      vmSize: 'Standard_F2'
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

resource attachedManagedDisk 'Microsoft.Compute/disks@2023-10-02' = {
  name: attachedOsDiskName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Copy'
    }
    diskSizeGB: 30
    encryption: {
      type: 'EncryptionAtRestWithPlatformKey'
    }
    networkAccessPolicy: 'AllowAll'
    hyperVGeneration: 'V1'
    publicNetworkAccess: 'Enabled'
    supportedCapabilities: {
      architecture: 'x64'
    }
    osType: 'Linux'
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
        managedDisk: {
          id: attachedManagedDisk.id
        }
        caching: 'ReadWrite'
        createOption: 'Attach'
        name: attachedOsDiskName
        osType: 'Linux'
        writeAcceleratorEnabled: false
      }
    }
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
          primary: true
          privateIPAddressVersion: 'IPv4'
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
        }
      }
    ]
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
  }
}
