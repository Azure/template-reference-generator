param resourceName string = 'acctest0001'
param location string = 'westus'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: '${resourceName}-vm'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: networkInterface.id
          properties: {
            primary: true
          }
        }
      ]
    }
    osProfile: {
      adminPassword: adminPassword
      adminUsername: 'testadmin'
      computerName: '${resourceName}-vm'
      linuxConfiguration: {
        disablePasswordAuthentication: false
      }
    }
    storageProfile: {
      imageReference: {
        offer: '0001-com-ubuntu-server-jammy'
        publisher: 'Canonical'
        sku: '22_04-lts'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: '${resourceName}-osdisk'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
      }
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
  name: '${resourceName}-vnet'
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
    privateEndpointVNetPolicies: 'Disabled'
  }
}

resource extension 'Microsoft.Compute/virtualMachines/extensions@2024-03-01' = {
  name: 'network-watcher'
  location: location
  parent: virtualMachine
  properties: {
    enableAutomaticUpgrade: false
    publisher: 'Microsoft.Azure.NetworkWatcher'
    suppressFailures: false
    type: 'NetworkWatcherAgentLinux'
    typeHandlerVersion: '1.4'
    autoUpgradeMinorVersion: true
  }
}

resource networkWatcher 'Microsoft.Network/networkWatchers@2024-05-01' = {
  name: '${resourceName}-nw'
  location: location
}

resource packetCapture 'Microsoft.Network/networkWatchers/packetCaptures@2024-05-01' = {
  name: '${resourceName}-pc'
  parent: networkWatcher
  properties: {
    storageLocation: {
      filePath: '/var/captures/packet.cap'
    }
    target: virtualMachine.id
    targetType: 'AzureVM'
    timeLimitInSeconds: 18000
    totalBytesPerSession: 1073741824
    bytesToCapturePerPacket: 0
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: 'internal'
  parent: virtualNetwork
  properties: {
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    defaultOutboundAccess: true
  }
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: '${resourceName}-nic'
  location: location
  properties: {
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    ipConfigurations: [
      {
        name: 'ipconfig1'
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
