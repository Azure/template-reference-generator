param resourceName string = 'acctest0001'
param location string = 'westeurope'
@secure()
@description('The administrator password for the virtual machine')
param adminPassword string

resource virtualMachine 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: resourceName
  location: location
  properties: {
    additionalCapabilities: {}
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
    priority: 'Regular'
    storageProfile: {
      osDisk: {
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        name: 'myosdisk-230630033106863551'
        osType: 'Linux'
        writeAcceleratorEnabled: false
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
      dataDisks: []
      imageReference: {
        offer: 'UbuntuServer'
        publisher: 'Canonical'
        sku: '18.04-LTS'
        version: 'latest'
      }
    }
    extensionsTimeBudget: 'PT1H30M'
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
      allowExtensionOperations: true
      computerName: resourceName
      linuxConfiguration: {
        provisionVMAgent: true
        ssh: {
          publicKeys: []
        }
        disablePasswordAuthentication: false
        patchSettings: {
          assessmentMode: 'ImageDefault'
          patchMode: 'ImageDefault'
        }
      }
      secrets: []
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
          privateIPAllocationMethod: 'Dynamic'
          subnet: {}
          primary: true
          privateIPAddressVersion: 'IPv4'
        }
      }
    ]
  }
}

resource schedule 'Microsoft.DevTestLab/schedules@2018-09-15' = {
  name: resourceName
  location: location
  properties: {
    dailyRecurrence: {
      time: '0100'
    }
    notificationSettings: {
      emailRecipient: ''
      status: 'Disabled'
      timeInMinutes: 30
      webhookUrl: ''
    }
    status: 'Enabled'
    taskType: 'ComputeVmShutdownTask'
    timeZoneId: 'Pacific Standard Time'
  }
  tags: {
    environment: 'Production'
  }
}
