param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

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

resource schedule 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: resourceName
  location: location
  properties: {
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    timeZoneId: 'Pacific Standard Time'
    dailyRecurrence: {
      time: '0100'
    }
    notificationSettings: {
      emailRecipient: ''
      status: 'Disabled'
      timeInMinutes: 30
      webhookUrl: ''
    }
  }
  tags: {
    environment: 'Production'
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    additionalCapabilities: {}
    extensionsTimeBudget: 'PT1H30M'
    priority: 'Regular'
    storageProfile: {
      imageReference: {
        sku: '18.04-LTS'
        version: 'latest'
        offer: 'UbuntuServer'
        publisher: 'Canonical'
      }
      osDisk: {
        caching: 'ReadWrite'
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: 'myosdisk-230630033106863551'
        osType: 'Linux'
        writeAcceleratorEnabled: false
      }
      dataDisks: []
    }
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
      vmSize: 'Standard_B2s'
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
      adminUsername: 'testadmin'
      allowExtensionOperations: true
      computerName: resourceName
      linuxConfiguration: {
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
        disablePasswordAuthentication: false
      }
      secrets: []
      adminPassword: adminPassword
    }
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-07-01' = {
  name: resourceName
  location: location
  properties: {
    subnets: []
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    dhcpOptions: {
      dnsServers: []
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2022-07-01' = {
  name: resourceName
  parent: virtualNetwork
  properties: {
    serviceEndpoints: []
    addressPrefix: '10.0.2.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
    serviceEndpointPolicies: []
  }
}
