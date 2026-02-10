param resourceName string = 'acctest0001'
param location string = 'eastus'

resource networkInterface 'Microsoft.Network/networkInterfaces@2024-05-01' = {
  name: resourceName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'internal'
        properties: {
          primary: false
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

resource restorePointCollection 'Microsoft.Compute/restorePointCollections@2024-03-01' = {
  name: resourceName
  location: location
  properties: {
    source: {}
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: resourceName
  location: location
  properties: {
    priority: 'Regular'
    storageProfile: {
      osDisk: {
        osType: 'Linux'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      dataDisks: []
      imageReference: {
        offer: '0001-com-ubuntu-server-jammy'
        publisher: 'Canonical'
        sku: '22_04-lts'
        version: 'latest'
      }
    }
    additionalCapabilities: {}
    extensionsTimeBudget: 'PT1H30M'
    applicationProfile: {
      galleryApplications: []
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: false
        storageUri: ''
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_F2'
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
      adminUsername: 'adminuser'
      allowExtensionOperations: true
      computerName: resourceName
      linuxConfiguration: {
        ssh: {
          publicKeys: [
            {
              keyData: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC+wWK73dCr+jgQOAxNsHAnNNNMEMWOHYEccp6wJm2gotpr9katuF/ZAdou5AaW1C61slRkHRkpRRX9FA9CYBiitZgvCCz+3nWNN7l/Up54Zps/pHWGZLHNJZRYyAB6j5yVLMVHIHriY49d/GZTZVNB8GoJv9Gakwc/fuEZYYl4YDFiGMBP///TzlI4jhiJzjKnEvqPFki5p2ZRJqcbCiF4pJrxUQR/RXqVFQdbRLZgYfJ8xGB878RENq3yQ39d8dVOkq4edbkzwcUmwwwkYVPIoDGsYLaRHnG+To7FvMeyO7xDVQkMKzopTQV8AuKpyvpqu0a9pWOMaiCyDytO7GGN you@me.com'
              path: '/home/adminuser/.ssh/authorized_keys'
            }
          ]
        }
        disablePasswordAuthentication: true
        patchSettings: {
          patchMode: 'ImageDefault'
          assessmentMode: 'ImageDefault'
        }
        provisionVMAgent: true
      }
      secrets: []
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-05-01' = {
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
    privateEndpointVNetPolicies: 'Disabled'
    subnets: []
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
    serviceEndpoints: []
    addressPrefix: '10.0.0.0/24'
    defaultOutboundAccess: true
    delegations: []
    privateEndpointNetworkPolicies: 'Disabled'
  }
}
